import QtQuick 2.0
import QtQuick.Controls 2.2

TabButton {
    property int index: 1
    text: index.toString()
    signal loadClicked()

    Image {
        source: parent.checked ? "qrc:///images/open_folder.png" : "qrc:///images/open_folder_inactive.png"
        height: parent.height*0.5
        width: Math.min(height, parent.width * 0.4)
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: {
                loadClicked()
            }
        }
    }

}
