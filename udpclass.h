#ifndef UDPCLASS_H
#define UDPCLASS_H

#include <QObject>
#include <QUdpSocket>
#include <QHostAddress>

class UdpClass : public QObject
{
    Q_OBJECT
public:
    explicit UdpClass(QObject *parent = NULL);
    ~UdpClass();
    Q_INVOKABLE void setAddress(QString host, int port);
    Q_INVOKABLE void sendUDPMessage(QString message);

private:
    QHostAddress udpHost;
    int udpPort;
    QUdpSocket * udpSocket;

};

#endif // UDPCLASS_H
