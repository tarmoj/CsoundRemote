#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udpclass.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);

    UdpClass udpSender;
    udpSender.setAddress("127.0.0.1", 6006);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("csound", &udpSender);  // so csound.copmpileOrc() etc can be used

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
