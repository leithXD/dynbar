import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    required property var pill

    function activateWallpaper(index) {
        Shellstate.wallpaperPath = WallpapersService.files[index];
        let path = WallpapersService.files[index];
        if (Shellstate.wallpaper !== path) {
            Quickshell.execDetached(["dynbar", "wallpaper", "move", Shellstate.wallpaperPath, WallpapersService.wallpaperSymlink]);
            if (path.endsWith(".mp4")) {
                var cleanOriginal = path.toString().replace("file://", "");
                var fileName = cleanOriginal.split("/").pop().replace(/\.[^/.]+$/, "");
                var cachedPath = Shellstate.home + "/.cache/dynbar/liveWallpapers/" + fileName + ".jpg";
                Shellstate.wallpaper = cachedPath;
                Quickshell.execDetached(["matugen", "image", WallpapersService.getCachedPath(cleanOriginal), "--source-color-index", "0"]);
            } else {
                Shellstate.wallpaper = path;
                var cleanPath = Shellstate.wallpaper.toString().replace("file://", "");
                Quickshell.execDetached(["matugen", "image", WallpapersService.getCachedPath(cleanPath), "--source-color-index", "0"]);
            }
        }
        pill.toggleWallpaper();
    }

    implicitWidth: 1200
    implicitHeight: 330
    Component.onCompleted: root.forceActiveFocus()
    Keys.onRightPressed: {
        if (wallpaperList.currentIndex < wallpaperList.count - 1)
            wallpaperList.incrementCurrentIndex();
        else
            wallpaperList.currentIndex = 0;
    }
    Keys.onLeftPressed: {
        if (wallpaperList.currentIndex > 0)
            wallpaperList.decrementCurrentIndex();
        else
            wallpaperList.currentIndex = wallpaperList.count - 1;
    }
    Keys.onEscapePressed: pill.toggleWallpaper()
    Keys.onReturnPressed: {
        activateWallpaper(wallpaperList.currentIndex);
    }
    focus: true

    ListView {
        id: wallpaperList

        height: 250
        width: root.implicitWidth
        orientation: ListView.Horizontal
        anchors.centerIn: parent
        spacing: 5
        model: WallpapersService.files
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: width / 2 - 225
        preferredHighlightEnd: width / 2 + 225
        highlightMoveDuration: 300
        currentIndex: Math.floor(wallpaperList.count / 2) // start roughly in the middle

        delegate: ClippingRectangle {
            id: container

            required property var modelData
            required property int index

            width: 450
            height: width * 9 / 16
            scale: 0.8
            color: Colors.layer(Colors.md3.inverse_on_surface, 2)
            radius: 20
            states: [
                State {
                    name: "selected"
                    when: container.ListView.isCurrentItem

                    PropertyChanges {
                        target: container
                        scale: 1.1
                    }

                }
            ]

            Image {
                id: wall

                anchors.fill: parent
                sourceSize.width: 450
                sourceSize.height: 253
                cache: true
                fillMode: Image.PreserveAspectCrop
                mipmap: true
                source: WallpapersService.getCachedPath(container.modelData)
            }

            MaterialLoading {
                loading: wall.status !== Image.Ready
                width: 100
                height: 100
                duration: 600
                spacing: 40
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.activateWallpaper(container.index);
                }
            }

            Spring on scale {
            }

        }

    }

}
