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
        if (Shellstate.wallpaper !== WallpapersService.files[wallpaperList.currentIndex]) {
            Shellstate.wallpaper = WallpapersService.files[wallpaperList.currentIndex];
            var cleanPath = Shellstate.wallpaper.toString().replace("file://", "");
            Quickshell.execDetached(["matugen", "image", cleanPath, "--source-color-index", "0"]);
            Quickshell.execDetached(["dynbar", "wallpaper", "move", cleanPath]);
        }
        pill.toggleWallpaper();
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

            width: 450
            height: width * 9 / 16
            scale: ListView.isCurrentItem ? 1 : 0.8
            color: Colors.layer(Colors.md3.inverse_on_surface, 2)
            radius: 20

            Image {
                id: wall

                anchors.fill: parent
                sourceSize.width: width
                sourceSize.height: height
                asynchronous: true
                cache: true
                fillMode: Image.PreserveAspectCrop
                mipmap: true
                source: WallpapersService.getCachedPath(container.modelData)
            }

            MaterialLoading {
                loading: wall.status !== Image.Ready
                width: 100
                height: 100
                duration: 200
                spacing: 40
                anchors.centerIn: parent
            }

            Spring on scale {
            }

        }

    }

}
