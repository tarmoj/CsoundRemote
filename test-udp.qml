import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    color: "#17dd09"

    anchors.fill: parent

    Column {
        Button {
            text: "Event 1"
            onClicked: udpSender.sendMessage("$i 1 0 1");

        }

    }



}
