#include "udpclass.h"
#include <QNetworkInterface>
//#include <QNetworkDatagram> // OK from  Qt 5.9


UdpClass::UdpClass(QObject *parent)
{
	sendHost =  QHostAddress::LocalHost;
	sendPort = 6006;
	sendSocket  = new QUdpSocket(this);
	// receiving
	receiveSocket = new QUdpSocket(this);
	receivePort = RECEIVE_PORT;
	receiveSocket->bind(QHostAddress::Any, receivePort );

	connect(receiveSocket, SIGNAL(readyRead()),
			this, SLOT(readPendingDatagrams()));

}

UdpClass::~UdpClass() {
	sendSocket->close();
	receiveSocket->close();
}

void UdpClass::setAddress(QString host, quint16 port)
{
    qDebug()<<"Setting address to: "<<host << ":" <<port;
	sendHost = QHostAddress(host);
	sendPort = port;
}

void UdpClass::setReceivingPort(int port) // TODO: test this? If the old port is released? do we need to open/close/recreate the socket?
{
	receivePort = port;
	if (receiveSocket->isOpen()) {
		receiveSocket->close();
	}
    receiveSocket->bind(QHostAddress::Any, receivePort );
}

//TODO: closeEvent


void  UdpClass::sendMessage(QString message)
{
    QByteArray data = message.toLocal8Bit().data();
    qDebug()<<"Send: "<<message;

	qint64 retval=sendSocket->writeDatagram(data, sendHost, sendPort);
	qDebug()<<"Bytes sent: "<<retval;
}

void UdpClass::setControlChannel(QString channel, double value)
{
	sendMessage("@"+channel + " " + QString::number(value));
}

void UdpClass::setStringChannel(QString channel, QString string)
{
	sendMessage("%"+channel + " " + string);
}

void UdpClass::compileOrc(QString code)
{
	sendMessage(code);
}

void UdpClass::readScore(QString score)
{
	sendMessage("$"+score);
}


// new is CSound 6.10 for requesting chnalle values to listening port of this computer
// :@[channel] [address] [port] -  for control values
// :%[channel] [address] [port] - for string values
void UdpClass::requestControlChannelValue(QString channel)
{
	QString myIpAddress = getLocalAddress();
	sendMessage(":@"+channel+ " " + myIpAddress + " " + QString::number(receivePort));
}

void UdpClass::requestStringChannelValue(QString channel)
{
	QString myIpAddress = getLocalAddress();
	sendMessage(":%"+channel+ " " + myIpAddress + " " + QString::number(receivePort));
}

double UdpClass::getControlChannel(QString channel)
{
	if (controlChannelValues.contains(channel)) {
		qDebug()<<"Value found: " << controlChannelValues[channel];
		return controlChannelValues[channel];
	} else {
		return -1;
	}
}

QString UdpClass::getStringChannel(QString channel)
{
	if (stringChannelValues.contains(channel)) {
		qDebug()<<"String found: " << stringChannelValues[channel];
		return stringChannelValues[channel];
	} else {
		return "none";
	}
}

void UdpClass::closeCsound()
{
	sendMessage("##close##");
}

// to test you can do in bash: echo -n "hello2" >/dev/udp/127.0.0.1/60606
void UdpClass::readPendingDatagrams()
{
	while (receiveSocket->hasPendingDatagrams()) {
		QByteArray buffer; // for older Qt
		buffer.resize(receiveSocket->pendingDatagramSize());
		receiveSocket->readDatagram(buffer.data(), buffer.size());
		QString response = QString(buffer);
//		QNetworkDatagram datagram = receiveSocket->receiveDatagram(); // OK in Qt 5.9
//		QString response = QString(datagram.data());
		qDebug()<<"Recieved " << response;
		QStringList messageParts = response.split("::");
		if (messageParts.count()>=2) {
			QString channel = messageParts[0];
			bool ok;
			double value = messageParts[1].toDouble(&ok);
			if (ok) {
				controlChannelValues[channel] = value;
				emit newControlChannelValue(channel, value);
			} else {
				stringChannelValues[channel] = messageParts[1]; // otherwise it is probably string
				emit newStringChannelValue(channel, messageParts[1]);
			}
		}
	}
}

QString UdpClass::getLocalAddress()
{
	QString address = QString();
	QList <QHostAddress> localAddresses = QNetworkInterface::allAddresses();
	for(int i = 0; i < localAddresses.count(); i++) {

		if(!localAddresses[i].isLoopback())
			if (localAddresses[i].protocol() == QAbstractSocket::IPv4Protocol ) {
				address = localAddresses[i].toString();
				qDebug() << "YOUR IP: " << address;
				break; // get the first address (avoid bridges etc)

		}

	}
	return address;
}
