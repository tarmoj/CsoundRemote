#ifndef UDPCLASS_H
#define UDPCLASS_H

#include <QObject>
#include <QUdpSocket>
#include <QHostAddress>

#define RECEIVE_PORT 60606 // hardcoded for now

class UdpClass : public QObject
{
    Q_OBJECT
public:
    explicit UdpClass(QObject *parent = NULL);
    ~UdpClass();
    Q_INVOKABLE void setAddress(QString host, int port);
	Q_INVOKABLE void sendMessage(QString message);
//	Q_INVOKABLE void setChannel(QString channel, double value);
//	Q_INVOKABLE void compileOrc(QString code);
//	Q_INVOKABLE void sendEvent(QString event);
	Q_INVOKABLE void requestControlChannelValue(QString channel);
//	Q_INVOKABLE void requestStringChannelValue(QString channel);
	Q_INVOKABLE double getControlChannel(QString channel);
//	Q_INVOKABLE QString getStringChannel(QString channel);

signals:
	void newChannelValue(QString channel, double value);


private:

	QHostAddress sendHost;
	int sendPort, receivePort;
	QUdpSocket * sendSocket, * receiveSocket;
	QHash <QString, double> channelValues;

private slots:
	void readPendingDatagrams();

};

#endif // UDPCLASS_H
