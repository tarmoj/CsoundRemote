#include "udpclass.h"
#include <QNetworkDatagram>
#include <QNetworkInterface>

UdpClass::UdpClass(QObject *parent)
{
	sendHost =  QHostAddress::LocalHost;
	sendPort = 6006;
	sendSocket  = new QUdpSocket(this);
	// receiving
	receiveSocket = new QUdpSocket(this);
	receiveSocket->bind(QHostAddress::Any, RECEIVE_PORT);

	connect(receiveSocket, SIGNAL(readyRead()),
			this, SLOT(readPendingDatagrams()));

}

UdpClass::~UdpClass() {
	sendSocket->close();
	receiveSocket->close();
}

void UdpClass::setAddress(QString host, int port)
{
    qDebug()<<"Setting address to: "<<host << ":" <<port;
	sendHost = QHostAddress(host);
	sendPort = port;
}

//TODO: closeEvent


void  UdpClass::sendMessage(QString message)
{
    QByteArray data = message.toLocal8Bit().data();
    qDebug()<<"Send: "<<message;

	int retval=sendSocket->writeDatagram(data, sendHost, sendPort);
	qDebug()<<"Bytes sent: "<<retval;
}


// new is CSound 6.10 for requesting chnalle values to listening port of this computer
// :@[channel] [address] [port] -  for control values
// :%[channel] [address] [port]
void UdpClass::requestControlChannelValue(QString channel)
{
	QString myIpAddress = getLocalAddress();
	qDebug()<<"My IP: "<< myIpAddress;
	QString myPort = QString::number(RECEIVE_PORT);

	sendMessage(":@"+channel+ " " + myIpAddress + " " + myPort);
}

double UdpClass::getControlChannel(QString channel)
{
	if (channelValues.contains(channel)) {
		qDebug()<<"Value found: " << channelValues[channel];
		return channelValues[channel];
	} else {
		return -1;
	}
}

// to test you can do in bash: echo -n "hello2" >/dev/udp/127.0.0.1/60606
void UdpClass::readPendingDatagrams()
{
	while (receiveSocket->hasPendingDatagrams()) {
		QNetworkDatagram datagram = receiveSocket->receiveDatagram();
		//processTheDatagram(datagram);
		QString response = QString(datagram.data());
		qDebug()<<"Recieved " << response;
		QStringList messageParts = response.split("::");
		if (messageParts.count()>=2) {
			QString channel = messageParts[0];
			bool ok;
			double value = messageParts[1].toDouble(&ok);
			if (ok) {
				channelValues[channel] = value;
				emit newChannelValue(channel, value);
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
