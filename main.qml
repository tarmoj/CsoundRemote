import QtQuick 2.9
//import QtQuick.Controls 1.4  // for Qt<5.7
import QtQuick.Controls 2.2 // better, for android

//import QtQuick.Dialogs 1
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import QtSensors 5.9

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
            clip: true
            //anchors.fill: parent // NB! this creates conflicting anchors!
            UiPage {
                id: qmlPage1
                anchors.fill: parent
            }
        }

        Page {
            id: page3
            width: 600
            height: 400
            clip: true

            UiPage {
                id: qmlPage2
                anchors.fill: parent
            }
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Main")
        }
        TabButton { // should be wise to create separate element from it, not to copy-paste. Later.
            text: qsTr("1")
            Image {
                source: "qrc:///images/open_folder.png"
                height: parent.height*0.5
                width: Math.min(height, parent.width * 0.4)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -10  // make the MouseArea somewhat bigger
                    onClicked: {
                        tabBar.setCurrentIndex(1)
                        qmlPage1.showFileDialog = !qmlPage1.showFileDialog
                    }
                }
            }
        }
        TabButton {
            text: qsTr("2")
            Image {
                source: "qrc:///images/open_folder.png"
                height: parent.height*0.5
                width: Math.min(height, parent.width * 0.4)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    //anchors.margins: -10  // make the MouseArea somewhat bigger
                    onClicked: {
                        tabBar.setCurrentIndex(2)
                        qmlPage2.showFileDialog = !qmlPage2.showFileDialog
                    }
                }
            }
        }
    }

}
