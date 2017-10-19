#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udpclass.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    UdpClass udpSender;
    udpSender.setAddress("127.0.0.1", 6006);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("udpSender", &udpSender);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
