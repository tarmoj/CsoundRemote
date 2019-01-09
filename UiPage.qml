import QtQuick 2.9

Item {

    width: 600
    height: 400
    property string qmlFile: ""
    property string qmlFolder: ""
    property bool showFileDialog: false

    Component.onCompleted:   {
        filePicker.lastFolder = qmlFolder // to restore from settings
        if (qmlFile !== "") {
            showQmlContent(qmlFile)
        }
    }

    function showQmlContent(fileURL) {
        var component = Qt.createComponent(fileURL);
        var win = component.createObject(qmlContent);
        qmlContent.visible = true
    }

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
            qmlFile = fileURL
            var basename = fileURL.toString()
            basename = basename.slice(0, basename.lastIndexOf("/")+1)
            qmlFolder = basename
            //console.log("File selected: ", qmlFile, " in folder: ", qmlFolder)
            showQmlContent(fileURL)
            showFileDialog = false
        }
        onHidePressed: showFileDialog = false
        onClearPressed: {
            qmlContent.visible = false;
            qmlFile = ""
        }
    }



}
