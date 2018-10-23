import QtQuick 2.5
//import QtQuick.Controls 1.4  // for Qt<5.7
import QtQuick.Controls 2.0 // better, for android
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Page {
    width: 640
    height: 480
    id: mainPage
    property alias stringValueLabel: stringValueLabel
    property alias requestStringChannelField: requestStringChannelField
    property alias requestStringChannelButton: requestStringChannelButton
    property alias closeButton: closeButton
    property alias requestControlChannelButton: requestControlChannelButton
    property alias valueLabel: valueLabel
    property alias requestControlChannelField: requestControlChannelField
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

    Flickable {
        id: flickable1
        contentWidth: gridLayout.width
        contentHeight: gridLayout.height
        anchors.fill: parent
        anchors.margins: 6
        //                clip: true
        //                boundsBehavior:
        //                    Flickable.DragOverBounds


        GridLayout {
            id: gridLayout
            flow: GridLayout.LeftToRight
            columns: 3

            Label {
                id: label
                text: qsTr("Host")
            }

            TextField {
                id: hostField
                text: "192.168.1.199"
                Layout.fillWidth: true
                Layout.columnSpan: 2
            }

            Label {
                id: label1
                text: qsTr("Port")
                Layout.row: 2
            }

            SpinBox {
                id: portSpinBox
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
                text: "volume"
                placeholderText: qsTr("Text Field")
            }

            Slider {
                id: channelSlider
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
