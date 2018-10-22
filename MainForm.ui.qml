import QtQuick 2.5
//import QtQuick.Controls 1.4  // for Qt<5.7
import QtQuick.Controls 2.0 // better, for android
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Item {
    width: 640
    height: 480
    property alias stringValueLabel: stringValueLabel
    property alias requestStringChannelField: requestStringChannelField
    property alias requestStringChannelButton: requestStringChannelButton
    property alias backButton: backButton
    property alias closeButton: closeButton
    property alias externalUi: externalUi
    property alias requestControlChannelButton: requestControlChannelButton
    property alias valueLabel: valueLabel
    property alias requestControlChannelField: requestControlChannelField
    property alias uiArea: uiArea
    property alias loadButton: loadButton
    property alias orcField: orcField
    property alias stringChannel: stringChannel
    property alias stringChannelField: stringChannelField
    property alias send2stringChannelButton: send2stringChannelButton
    property alias orcButton: orcButton
    property alias channelSlider: channelSlider
    property alias hostField: hostField
    property alias portSpinBox: portSpinBox
    property alias updateButton: updateButton
    property alias channelField: channelField
    property alias eventField: eventField
    property alias eventbutton: eventbutton

    //    property alias button1: button1
    //    property alias button2: button2

    Rectangle {
        id: rectangle1
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        gradient: Gradient {
            GradientStop {
                id: gradientStop1
                position: 0
                color: "lightgrey"
            }


            GradientStop {
                position: 0.317
                color: "darkgrey"
            }


        }
        anchors.fill: parent



        Row {
            id: row1
            spacing: 5

            Button {
                id: backButton
                text: qsTr("Back")
            }

            Button {
                id: loadButton
                text: qsTr("Load QML")
            }

        }


        Item {
            id: externalUi
            anchors.top: row1.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: rectangle1.bottom
            visible: false
        }




        Item {
            id: uiArea
            anchors.bottom: parent.bottom
            anchors.top: row1.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.left: parent.left

            Flickable {
                id: flickable1
                contentWidth: gridLayout.width
                contentHeight: gridLayout.height
                anchors.fill: parent
                clip: true
                boundsBehavior:
                    Flickable.DragOverBounds


                GridLayout {
                    id: gridLayout
                    x: 5
                    y: 0
//                    anchors.right: parent.right
//                    anchors.left: parent.left
//                    anchors.top: parent.top
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    width: parent.width
                    flow: GridLayout.LeftToRight
                    columns: 3

                    Label {
                        id: label
                        text: qsTr("Host")
                    }

                    TextField {
                        id: hostField
                        //width: 250
                        text: "192.168.1.199"
                        Layout.fillWidth: true
                    }

                    Label {
                        id: label1
                        text: qsTr("Port")
                        Layout.row: 2
                    }

                    SpinBox {
                        id: portSpinBox
                        //width: 140
                        value: 6006
                        editable: true
                        stepSize: 1
                        from: 1000
                        to: 99999
                    }

                    Button {
                        id: updateButton
                        text: qsTr("Update")
                    }

                    Label {
                        id: label2
                        text: qsTr("Channel:")
                        Layout.row: 3
                    }

                    TextField {
                        id: channelField
                        //width: 140
                        text: "volume"
                        placeholderText: qsTr("Text Field")
                    }

                    Slider {
                        id: channelSlider
                        //width: 250
                    }

                    Label {
                        id: label3
                        text: qsTr("Event")
                    }

                    TextField {
                        id: eventField
                        text: "i 1 0 1"
                        placeholderText: qsTr("Text Field")
                    }

                    Button {
                        id: eventbutton
                        text: qsTr("Event")
                    }

                    Label {
                        id: label4
                        text: qsTr("CompileOrc")
                    }

                    TextField {
                        id: orcField
                        //width: 200
                        text: "gkValue init 1"
                    }

                    Button {
                        id: orcButton
                        text: qsTr("Send")
                    }

                    Button {
                        id: send2stringChannelButton
                        text: qsTr("Send String")
                    }

                    TextField {
                        id: stringChannel
                        //width: 140
                        text: "status"
                        placeholderText: qsTr("Text Field")
                    }


                    TextField {
                        id: stringChannelField
                        text: "OK"
                        placeholderText: qsTr("Text Field")
                    }

                    Button {
                        id: requestControlChannelButton
                        text: qsTr("Request ControlChannel")
                    }

                    TextField {
                        id: requestControlChannelField
                        text: qsTr("volume")
                    }

                    Label {
                        id: valueLabel
                        text: "Value"
                        //text: qsTr("Value")
                    }


                    Button {
                        id: requestStringChannelButton
                        text: qsTr("Request StringChannel")
                    }


                    TextField {
                        id: requestStringChannelField
                        text: qsTr("status")
                    }
                    Label {
                        id: stringValueLabel
                        text: "Value"
                    }

                    Button {
                        id: closeButton
                        text: qsTr("Close Csound")
                    }

                }

            }

        }




    }
    states: [
        State {
            name: "external"
            PropertyChanges { target: uiArea; visible: false; }
            PropertyChanges { target: externalUi; visible: true; }

        }
    ]

}
