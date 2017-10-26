import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: mainWindow
    title: qsTr("QML loading test")
    visible: true
    width: 640
    height: 480


    Connections {
        target:  udpSender

        onNewChannelValue: mainForm.valueLabel.text = value.toFixed(3)

    }

    MainForm {
        id: mainForm
        //anchors.top: loadQmlButton.bottom
        anchors.fill: parent
        //anchors.margins: 5

        Settings {
                id: settings
                //property alias host:  mainForm.hostField.text
                //property alias port: portSpinBox.value
                property alias lastQml: fileDialog.fileUrl
                property alias lastQmlPath: fileDialog.folder
            }

        loadButton.onClicked: fileDialog.visible = true

        updateButton.onClicked: {
            udpSender.setAddress(hostField.text, portSpinBox.value );
        }
        channelSlider.onValueChanged: udpSender.sendMessage("@"+channelField.text+" "+(200+channelSlider.value*100));
        eventbutton.onClicked: udpSender.sendMessage("$"+eventField.text)
        orcButton.onClicked: udpSender.sendMessage(orcField.text)
        send2stringChannelButton.onClicked: udpSender.sendMessage("%"+stringChannel.text + " " + stringChannelField.text )
        requestControlChannelButton.onClicked: {
            udpSender.requestControlChannelValue(requestControlChannelField.text)
        }


        FileDialog {
            id: fileDialog
            title: qsTr("choose QML file to load")
            selectMultiple : false
            nameFilters: [ "QML files (*.qml)"]
            //folder: shortcuts.home

            onAccepted: {
                var basename = fileUrl.toString()
                basename = basename.slice(0, basename.lastIndexOf("/")+1)
                folder = basename
                console.log("You chose: " + fileUrl + " in folder: " + basename)
                var component = Qt.createComponent(fileDialog.fileUrl);
                var win = component.createObject(mainForm.uiArea);
               //win.show();
            }
            onRejected: {
                console.log("Canceled")
            }

        }


    }







}
