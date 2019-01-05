import QtQuick 2.9

Item {

    width: 600
    height: 400
    property string qmlFile: ""
    property bool showFileDialog: true

    Item {
        id: qmlContent
        visible: true//!showFileDialog//filePicker.visible
        anchors.fill: parent
    }

    FilePicker {
        id: filePicker
        visible: showFileDialog
        anchors.fill: parent
        anchors.margins: 10
        onFileSelected: {
            console.log("File selected: ", fileURL)
            qmlFile = fileURL
            var component = Qt.createComponent(fileURL);
            var win = component.createObject(qmlContent);
            qmlContent.visible = true
            //visible = false
            showFileDialog = false
        }
        onHidePressed: showFileDialog = false
        onClearPressed: {
            qmlContent.visible = false;
        }
    }



}
