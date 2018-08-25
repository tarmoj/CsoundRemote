import QtQuick 2.0
import QtSensors 5.3

Rectangle {
    width: 600
    height: 480
    id: page

    anchors.fill : parent
    color: "lightblue"
    property real accY: 0 // longer axis on phone, portrait layout
    property real accX:0 // shorter side
    property real accZ:0

    Accelerometer {
        id: accel
        dataRate:20 // maybe has no influence, trust the timer
        active: true
        property real oldY: 0
        property double oldTimestamp:0

        onReadingChanged: {
            accY = Math.abs(reading.y) // influences breathing in or out
            accX = Math.abs(reading.x) // influences how much is a pitch mixed in
            accY = Math.abs(reading.z)
        }
    }

    Text {text: "X: "+accX+ " Y: " + accY + " Z: " + accZ }

    // from tvtennis example
    // Make a ball to bounce
    Rectangle {
        id: ball

        // Add a property for the target y coordinate
        property string direction : "right"

        x: 20; width: 20; height: 20; z: 1
        radius:  10
        color: "#80c342"

        // Move the ball to the right and back to the left repeatedly
        SequentialAnimation on x {
            loops: Animation.Infinite
            NumberAnimation { to: page.width - 40; duration: 2000 }
            PropertyAction { target: ball; property: "direction"; value: "left" }
            NumberAnimation { to: 20; duration: 2000 }
            PropertyAction { target: ball; property: "direction"; value: "right" }
        }

        // Make y move with a velocity of 200
        Behavior on y { SpringAnimation{ velocity: 200; }
        }

        Component.onCompleted: y = page.height-10; // start the ball motion

        // Detect the ball hitting the top or bottom of the view and bounce it
        onYChanged: {
            if (y <= 0) {
                y = page.height - 20;
            } else if (y >= page.height - 20) {
                y = 0;
            }
        }
    }



}
