//based partly on code by Copyright (c) 2017 Andrey Semenov, MIT license
// source:  https://github.com/dobokirisame/qml-filedialog/blob/master/FilePicker.qml

import QtQuick 2.8
import Qt.labs.folderlistmodel 2.2
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
        anchors.margins: 20
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        FolderListModel{
            id: folderModel
            nameFilters: ["*.qml"]
            showDirsFirst: true
            showDotAndDotDot: true
            folder: "file:///sdcard/"
        }

        Component {
            id: fileDelegate
            Item {
                width: parent.width
                height: 30
                //border.color: Material.foreground
                //radius: 4
                //color: "transparent"
                //color: Material.background//ListView.isCurrentItem ?  Material.accent : Material.background //"transparent"
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
                    color: parent.isActive ?  Material.accent : Material.foreground //Material.foreground
                    text: fileName
                    //font.underline: parent.isActive
                }
            }
        }

        model: folderModel
        delegate: fileDelegate
    }

}
