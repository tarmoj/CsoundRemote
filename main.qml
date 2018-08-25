import QtQuick 2.5
//import QtQuick.Controls 1.4  // for Qt<5.7
import QtQuick.Controls 2.0 // better, for android

import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
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


    MainForm {
        id: mainForm
        //anchors.top: loadQmlButton.bottom
        anchors.fill: parent
        //anchors.margins: 5
        property string lastHost: "192.168.1.199"
        property int lastPort: 6006

        Settings {
            id: settings
                property alias host:  mainForm.lastHost
                property alias port: mainForm.lastPort
                property alias lastQml: fileDialog.fileUrl
                property alias lastQmlPath: fileDialog.folder
            }

        Component.onCompleted: {
            mainForm.portSpinBox.value = lastPort;
            mainForm.hostField.text = lastHost;
            csound.setAddress(lastHost, lastPort);
        }

        loadButton.onClicked: fileDialog.visible = true

        backButton.onClicked: {
            state = ""
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


        FileDialog {
            id: fileDialog
            title: qsTr("choose QML file to load")
            selectMultiple : false
            //nameFilters: [ "QML files (*.qml)"]
            //folder: shortcuts.home

            onAccepted: {
                var basename = fileUrl.toString()
                basename = basename.slice(0, basename.lastIndexOf("/")+1)
                folder = basename
                console.log("You chose: " + fileUrl + " in folder: " + basename)

                mainForm.state = "external";
                var component = Qt.createComponent(fileDialog.fileUrl);
                var win = component.createObject(mainForm.externalUi);
            }
            onRejected: {
                console.log("Canceled")
            }

        }


    }







}
