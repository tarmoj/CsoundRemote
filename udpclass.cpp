#include "udpclass.h"

UdpClass::UdpClass(QObject *parent)
{
    udpHost =  QHostAddress::LocalHost;
    udpPort = 6006;
    udpSocket  = new QUdpSocket(this);
}

UdpClass::~UdpClass() {
    udpSocket->close();
}

void UdpClass::setAddress(QString host, int port)
{
    qDebug()<<"Setting address to: "<<host << ":" <<port;
    udpHost = QHostAddress(host);
    udpPort = port;
}



void  UdpClass::sendUDPMessage(QString message)
{
    QByteArray data = message.toLocal8Bit().data();
    qDebug()<<"Send: "<<message;

    int retval=udpSocket->writeDatagram(data, udpHost, udpPort);
    qDebug()<<"Bytes sent: "<<retval;
}
