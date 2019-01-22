import QtQuick 2.0

Rectangle {
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#86bbfe"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    Rectangle {
        id: ball
        x: 300
        y: 210
        width: 40
        height: 40
        radius: 20
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#fce743"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Behavior on x {
            NumberAnimation {
                easing.type: Easing.InBack
                duration: 500
            }
        }

        Behavior on y {
            NumberAnimation {
                easing.type: Easing.InElastic
                duration: 500
            }
        }

        onXChanged: {
            csound.setControlChannel("carr", 1 + x/parent.width)
            csound.setControlChannel("mod", 1 + y/parent.height)
        }

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            ball.x = mouse.x
            ball.y = mouse.y
            csound.readScore("i 1 0 0.5")
        }

    }

}
