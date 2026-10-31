import Qt.labs.folderlistmodel
import QtQuick
import Quickshell
import qs.Core
pragma Singleton

Singleton {
    id: root

    readonly property string dir: Quickshell.env("HOME") + Config.paths.wallpaperPath
    property var files: []

    function update() {
        const list = [];
        for (let i = 0; i < folder.count; i++) list.push(folder.get(i, "filePath"))
        files = list;
    }

    FolderListModel {
        id: folder

        folder: "file://" + root.dir
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp"]
        caseSensitive: false
        showDirs: false
        sortField: FolderListModel.Name
        onStatusChanged: {
            if (status === FolderListModel.Ready)
                root.update();

        }
        onCountChanged: root.update()
    }

}
