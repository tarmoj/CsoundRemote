import QtQuick 2.7
//import QtQuick.Controls 1.4  // for Qt<5.7
import QtQuick.Controls 2.0 // better, for android

import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import QtSensors 5.3

ApplicationWindow {
    id: mainWindow
    title: qsTr("Csound Remote")
    visible: true
    width: 640
    height: 480

    Connections {
        target:  csound

        onNewControlChannelValue: mainForm.valueLabel.text = value.toFixed(3)
        onNewStringChannelValue: mainForm.stringValueLabel.text = stringValue

    }

    Settings {
        id: settings
            property alias host:  mainForm.lastHost
            property alias port: mainForm.lastPort
            //property alias lastQml: fileDialog.fileUrl
            //property alias lastQmlPath: fileDialog.folder
        }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        MainForm {
            id: mainForm
            //anchors.top: loadQmlButton.bottom
            //anchors.fill: parent
            //anchors.margins: 5
            property string lastHost: "192.168.1.199"
            property int lastPort: 6006



            Component.onCompleted: {
                mainForm.portSpinBox.value = lastPort;
                mainForm.hostField.text = lastHost;
                csound.setAddress(lastHost, lastPort);
            }


            updateButton.onClicked: {
                csound.setAddress(hostField.text, portSpinBox.value );
                lastHost = hostField.text;
                lastPort = portSpinBox.value;
            }
            channelSlider.onValueChanged: csound.setControlChannel(channelField.text, channelSlider.value);
            eventbutton.onClicked: csound.readScore(eventField.text)
            orcButton.onClicked: csound.compileOrc(orcField.text)
            send2stringChannelButton.onClicked: csound.setStringChannel(stringChannel.text, stringChannelField.text)
            requestControlChannelButton.onClicked:            csound.requestControlChannelValue(requestControlChannelField.text)
            requestStringChannelButton.onClicked: csound.requestStringChannelValue(requestStringChannelField.text)
            closeButton.onClicked: csound.closeCsound() // you can use also csound.sendMessage(<message>) to do anything else

        }


        Page {
            id: page2
            width: 600
            height: 400
            //anchors.fill: parent // NB! this creates conflicting anchors!



            FileDialog {
                id: fileDialog
                title: qsTr("choose QML file to load")
                //selectMultiple : false
                nameFilters: [ "QML files (*.qml)"]
                folder: StandardPaths.writableLocation(StandardPaths.DownloadLocation)

                onAccepted: {
                    var basename =   file.toString()
                    basename = basename.slice(0, basename.lastIndexOf("/")+1)
                    folder = basename
                    console.log("You chose: " + file + " in folder: " + basename)

                    var component = Qt.createComponent(fileDialog.file);
                    var win = component.createObject(page2);
                }
                onRejected: {
                    console.log("Canceled")
                }

            }

        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Main")
        }
        TabButton {
            text: qsTr("Page 2")
            Button {
                anchors.right: parent.right
                anchors.rightMargin: 5
                text: "Load"
                onClicked: fileDialog.visible = true

            }
        }
    }

}
