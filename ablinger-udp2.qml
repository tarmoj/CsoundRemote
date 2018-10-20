import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQml 2.2 // for Timer


Rectangle {
    id: ablingerRect
    width: 640
    height: 480
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


    Column{
        x:5; y:5
        id: firstColumn
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5
        //anchors.fill: parent
        spacing:  5;

        Label {font.bold:  true; text: "Peter Ablinger Das Wirkliche als Vorgestelltes"}
        RowLayout {
            width: ablingerRect.width
            //height: 80
            spacing: 5
            id: topRow
            Grid {
                spacing: 5
                columns: 2
                rows: 2

                Label {text:"Volume"}
                Slider { onValueChanged: csound.sendMessage("@volume " + value ); }

                Button {
                    text: "Test"
                    onClicked: {
                        csound.sendMessage("@test " + Math.random()*100)
                        csound.requestControlChannelValue("test");
                        testTimer.start()

                    }

                    Timer {
                        id: testTimer
                        interval: 100
                        running: false; repeat: false;
                        onTriggered: {
                            console.log("triggeerd")
                            testLabel.text = csound.getControlChannel("test")
                        }
                    }
                }

                Label {id: testLabel; text: "None"}
            }



            Button { id: stopButton;
                Layout.preferredWidth:  ablingerRect.width/3;
                Layout.fillHeight: true
                Layout.preferredHeight:  ablingerRect.height/6;
                text: "Stop";
                anchors.right: parent.right; anchors.rightMargin: 5;
                onClicked:  csound.sendMessage("$i -2 0 0 ");
            }

            //Button { text: "Start"; onClicked:  csound.sendMessage("$i 2 0 -1 ");  }

        }
    }


    TextArea {
        id: textviewer
        x: 5
        width: ablingerRect.width - 5
        anchors.top: firstColumn.bottom
        anchors.topMargin: 5
        anchors.bottom: nextButton.top
        anchors.bottomMargin: 5
        property string fileName: (Qt.platform.os == "android") ? "/mnt/sdcard/Download/ablinger.txt" : "./ablinger.txt";

        Component.onCompleted:  {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "./ablinger.txt");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == XMLHttpRequest.DONE) {
                    var response = xhr.responseText;
                    // use file contents as required
                    textviewer.text = response;
                }
            };
            xhr.send();
        }

        text: "Ablinger\n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n \n1\n2\n3\n4\n5\n6\n7\n"

        readOnly: true

        wrapMode: Text.WordWrap


    }


    Button {
        id: nextButton
        x:5
        text: "0"
        width: ablingerRect.width -5
        height:  ablingerRect.height/4
        anchors.bottom: ablingerRect.bottom
        anchors.bottomMargin:  5
        onClicked:  {
            var value = parseInt(this.text);
            console.log(value);
            while  (value === parseInt(this.text))   { // to make sure that there is no repeating numbers
                value = 1 + Math.floor(Math.random()*9);
                console.log(value);
            }
            text = value.toString();
            var command =  "schedule 1,0,0," +  value.toString(); //"$i 1 0 0 " + value.toString() + "\n"
            csound.sendMessage(command);
        }
    }




}
