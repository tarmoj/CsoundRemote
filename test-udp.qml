import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    color: "lightblue"
    anchors.fill: parent

    Column {
		x: 5; y:5
        Button {
            text: "Event 1"
            onClicked: csound.readScore("i 1 0 1");
        }
        Slider {width: 100; onPositionChanged: csound.setControlChannel("value", position) }
    }
}
