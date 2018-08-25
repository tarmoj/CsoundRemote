import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: ablingerRect
//    width: 640
//    height: 480
    anchors.fill: parent
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#a9ea27";
        }
        GradientStop {
            position: 1.00;
            color: "#ffffff";
        }
    }

    Column {
        width: parent.width
        spacing:  5;
        Label {text: "Peter Ablinger Das Wirkliche als Vorgestelltes"}
        Row {
            spacing: 5
            Label {text:"Volume"}

            Slider {  onPositionChanged: csound.sendMessage("@volume " + position ); }
            Button { text: "Start"; onClicked:  csound.sendMessage("$i 2 0 -1 ");  }
            Button { text: "Stop"; onClicked:  csound.sendMessage("$i -2 0 0 ");  }
        }

        // Button grid
        Grid {
            id: buttonGrid
            width: parent.width
            spacing: 10
            anchors.leftMargin: 5
            anchors.topMargin: 5
            columns: 3

            Repeater {
                model: 12

                Button {
                    text: index;
                    width: parent.width/3-20
                    height: ablingerRect.height/6
                    onClicked: csound.sendMessage("@index "+index);
                }
            }

        }

    }

}
