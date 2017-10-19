import QtQuick 2.5
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: mainWindow
    title: qsTr("QML loading test")
    visible: true
    width: 640
    height: 480




    MainForm {
        id: mainForm
        //anchors.top: loadQmlButton.bottom
        anchors.fill: parent
        anchors.margins: 5

        loadButton.onClicked: fileDialog.visible = true

        updateButton.onClicked: {
            udpSender.setAddress(hostField.text, portSpinBox.value );
        }
        channelSlider.onValueChanged: udpSender.sendUDPMessage("@"+channelField.text+" "+(200+channelSlider.value*100));
        eventbutton.onClicked: udpSender.sendUDPMessage("$"+eventField.text)
        orcButton.onClicked: udpSender.sendUDPMessage(orcField.text)
        send2stringChannelButton.onClicked: udpSender.sendUDPMessage("%"+stringChannel.text + " " + stringChannelField.text )



        FileDialog {
            id: fileDialog
            title: qsTr("choose QML file to load")
            selectMultiple : false
            //nameFilters: [ "QML files (*.qml)"]
            //folder: shortcuts.home
            onAccepted: {
                console.log("You chose: " + fileDialog.fileUrls)
                var component = Qt.createComponent(fileDialog.fileUrls);
                var win = component.createObject(mainForm.uiArea);
               //win.show();
            }
            onRejected: {
                console.log("Canceled")
            }

        }


    }







}
