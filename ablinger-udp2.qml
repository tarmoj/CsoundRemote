import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4


Rectangle {
    id: ablingerRect
    //    width: 640
    //    height: 480
    anchors.fill: parent
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#ffffff"
        }
        GradientStop {
            position: 1.00;
            color: "#919e85";
        }
    }

    ColumnLayout {
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent
        Layout.fillHeight: true
        spacing:  5;
        Label {text: "Peter Ablinger Das Wirkliche als Vorgestelltes"}
        Row {
            spacing: 5
            Label {text:"Volume"}

            Slider {  onValueChanged: udpSender.sendUDPMessage("@volume " + value ); }
            //Button { text: "Start"; onClicked:  udpSender.sendUDPMessage("$i 2 0 -1 ");  }
            Button { text: "Stop"; onClicked:  udpSender.sendUDPMessage("$i -2 0 0 ");  }
        }

        ScrollView {
            width: ablingerRect.width



        TextArea {
            id: textviewer
            Layout.fillWidth: true
            Layout.fillHeight: true
            height: ablingerRect.height*0.6
            anchors.horizontalCenter: parent.horzontalCenter
            width: ablingerRect.width

            text: "Ablinger\n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n"

            readOnly: true

            wrapMode: Text.WordWrap
            //background: Rectangle {anchors.fill: parent; color: "white"}

//            MouseArea {
//                anchors.fill: parent
//                onDoubleClicked: console.log("double clicked");
//            }

           }
        }

        Button {
            id: nextButton
            //Layout.fillHeight:  true
            text: "Next filter"
            Layout.fillWidth: true
            Layout.minimumHeight: parent.height/4
            Layout.fillHeight: false
            //width: parent.width-10
            //Layout.fillHeight: true
            //Layout.maximumHeight:  parent.height/4
            anchors.horizontalCenter: parent.horzontalCenter
            anchors.bottom: ablingerRect.bottom
            anchors.bottomMargin:  5
            onClicked:  {
                var value = Math.floor(Math.random()*12);
                console.log(value);
                text = value.toString();
                var command =  "schedule 1,0,0," +  value.toString(); //"$i 1 0 0 " + value.toString() + "\n"
                udpSender.sendUDPMessage(command);
            }
        }


    }

}
