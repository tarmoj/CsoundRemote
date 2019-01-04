#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udpclass.h"

#ifdef Q_OS_ANDROID

#include <QtAndroidExtras/QtAndroid>

bool checkPermission() {
    QtAndroid::PermissionResult r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
    if(r == QtAndroid::PermissionResult::Denied) {
        QtAndroid::requestPermissionsSync( QStringList() << "android.permission.WRITE_EXTERNAL_STORAGE" );
        r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if(r == QtAndroid::PermissionResult::Denied) {
             return false;
        }
   }
   return true;
}
#endif


int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QApplication app(argc, argv);

    UdpClass udpSender;
    udpSender.setAddress("127.0.0.1", 6006);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("csound", &udpSender);  // so csound.copmpileOrc() etc can be used

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
#ifdef Q_OS_ANDROID
    checkPermission();
#endif

    return app.exec();
}
