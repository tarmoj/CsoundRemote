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
	Q_INVOKABLE void setAddress(QString host, quint16 port);
	Q_INVOKABLE void setReceivingPort(int port);
	Q_INVOKABLE void sendMessage(QString message);
	Q_INVOKABLE void setControlChannel(QString channel, double value);
	Q_INVOKABLE void setStringChannel(QString channel, QString string);
	Q_INVOKABLE void compileOrc(QString code);
	Q_INVOKABLE void readScore(QString score);
	Q_INVOKABLE void requestControlChannelValue(QString channel);
	Q_INVOKABLE void requestStringChannelValue(QString channel);
	Q_INVOKABLE double getControlChannel(QString channel);
	Q_INVOKABLE QString getStringChannel(QString channel);
	Q_INVOKABLE void closeCsound();


	Q_INVOKABLE QString getLocalAddress();
signals:
	void newControlChannelValue(QString channel, double value);
	void newStringChannelValue(QString channel, QString stringValue);

private:

	QHostAddress sendHost;
	quint16 sendPort, receivePort;
	QUdpSocket * sendSocket, * receiveSocket;
	QHash <QString, double> controlChannelValues;
	QHash <QString, QString> stringChannelValues;

private slots:
	void readPendingDatagrams();

};

#endif // UDPCLASS_H
