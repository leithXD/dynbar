import Qt.labs.folderlistmodel
import QtQuick
import Quickshell
import qs.Core
pragma Singleton

Singleton {
    id: root

    readonly property string dir: Quickshell.env("HOME") + Config.paths.wallpaperPath
    readonly property string cacheLive: Quickshell.env("HOME") + "/.cache/dynbar/liveWallpapers/"
    readonly property string cache: Quickshell.env("HOME") + "/.cache/dynbar/thumbnails/"
    property var files: []

    function update() {
        const list = [];
        for (let i = 0; i < folder.count; i++) list.push(folder.get(i, "filePath"))
        files = list;
    }

    function getCachedPath(path) {
        return root.cache + path.substring(root.dir.length + 1).replace(/\.(png|jpeg|webp|mp4)$/i, ".jpg");
    }

    FolderListModel {
        id: folder

        folder: "file://" + root.dir
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp", "*.mp4"]
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
