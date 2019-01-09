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
        qmlContent.source = fileURL + "?t=" + Date.now() // to avoid from loading from QML cache if you need to reload the file
    }

    Loader {
        id: qmlContent
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
            showQmlContent(fileURL)
            showFileDialog = false
        }
        onHidePressed: showFileDialog = false
        onClearPressed: {
            qmlContent.source = ""; // unload content
            qmlFile = ""
        }
    }



}
