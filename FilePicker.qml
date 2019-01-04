//based partly on code by Copyright (c) 2017 Andrey Semenov, MIT license
// source:  https://github.com/dobokirisame/qml-filedialog/blob/master/FilePicker.qml

import QtQuick 2.8
import Qt.labs.folderlistmodel 2.2
import Qt.labs.platform 1.0
import QtQuick.Controls.Material 2.3

Item {
    width:200
    height: 400
    anchors.fill: parent
    signal fileSelected(string fileURL)


    function currentFolder() {
        return folderModel.folder;
    }

    function isFolder(fileName) {
        return folderModel.isFolder(folderModel.indexOf(folderModel.folder + "/" + fileName));
    }
    function canMoveUp() {
        return folderModel.folder.toString() !== "file:///";
    }

    function onItemClick(fileName, fileURL) {
        if(!isFolder(fileName)) {
            console.log("filenam, fileURL", fileName)
            fileSelected(fileURL) // emit signal to parent
            return;
        }
        if(fileName === ".." && canMoveUp()) {
            folderModel.folder = folderModel.parentFolder
        } else if(fileName !== ".") {
            if(folderModel.folder.toString() === "file:///") {
                folderModel.folder += fileName
            } else {
                folderModel.folder += "/" + fileName
            }
        }
    }


    ListView {
        id: fileList
        anchors.fill: parent
        anchors.margins: 10
        focus: true
        header: Text { text:qsTr("Load QML file"); color: Material.foreground; font.bold: true; font.italic:  true }

        FolderListModel{
            id: folderModel
            nameFilters: ["*.qml"]
            showDirsFirst: true
            showDotAndDotDot: true
            folder: StandardPaths.writableLocation(StandardPaths.DownloadLocation)// "file:///sdcard/"
        }

        Component {
            id: fileDelegate
            Rectangle {
                width: parent.width
                height: 30
                //border.color: Material.foreground
                radius: 8
                //color: "transparent"
                color: isActive ? "#19ffffff" : "transparent"
                property bool isActive: ListView.isCurrentItem

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Selected file: ", fileName )
                        fileList.currentIndex = index
                    }
                    onDoubleClicked:  {
                        onItemClick(fileName, fileURL)
                        //console.log("Name, URL, Path: ", fileName, fileURL, filePath)
                    }
                }
                Text {
                    width: parent.width
                    color: parent.isActive ?  Material.accent : Material.foreground
                    text: fileName
                }
            }
        }

        model: folderModel
        delegate: fileDelegate
    }

}
