#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "udpclass.h"

#ifdef Q_OS_ANDROID

#include <QtAndroidExtras/QtAndroid>

bool checkPermission() { // requires >= Qt 5.10
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
	QGuiApplication app(argc, argv);


#ifdef Q_OS_ANDROID
    checkPermission();
#endif

    UdpClass udpSender;
    udpSender.setAddress("127.0.0.1", 6006);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("csound", &udpSender);  // so csound.copmpileOrc() etc can be used

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	app.setWindowIcon(QIcon(":/images/cd-remote-icon.png"));
    return app.exec();
}
