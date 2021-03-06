#TEMPLATE = app

#QT += qml quick widgets network

QT += qml quick network
CONFIG += c++11

android: QT += androidextras

SOURCES += main.cpp \
    udpclass.cpp

HEADERS += \
	udpclass.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH +=  #/home/tarmo/src/Qt/5.12.0/android_armv7/qml/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

TARGET = "CsoundRemote"

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


DISTFILES += \
#    android/AndroidManifest.xml \
#    android/gradle/wrapper/gradle-wrapper.jar \
#    android/gradlew \
#    android/res/values/libs.xml \
#    android/build.gradle \
#    android/gradle/wrapper/gradle-wrapper.properties \
#    android/gradlew.bat \
	test-udp.qml \
	ablinger-udp.qml \
	ablinger-udp2.qml \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

#ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ios {
CONFIG -= bitcode

    QMAKE_INFO_PLIST = ios/Info.plist
    qml_demo_files = $$files($$PWD/test-udp.qml)
    QMAKE_BUNDLE_DATA += qml_demo_files
    #ios_icon.files = $$files($$PWD/ios/icons/AppIcon.appiconset/*.png)
    #ios_icon.files += $$files($$PWD/ios/icons/Itunes*.png)
    #QMAKE_BUNDLE_DATA += ios_icon
    #app_launch_images.files = $$PWD/ios/Launch.storyboard #$$files($$PWD/ios/launchimages/LaunchImage*.png) #$$PWD/ios/Launch.xib
    #QMAKE_BUNDLE_DATA += app_launch_images

}

macx {
    installer.path = $$PWD
    installer.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD -dmg # deployment
    INSTALLS += installer

}


