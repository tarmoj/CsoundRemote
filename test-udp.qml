import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    color: "#17dd09"

    anchors.fill: parent

    Column {
        Button {
            x:20; y:50
            width: 200
            height:50
            text: "Event 1"
            onClicked: csound.sendMessage("$i 1 0 1");

        }

    }



}
