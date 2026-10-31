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

    implicitWidth: 900
    implicitHeight: 400

    TextField {
        id: search // useless rn

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        width: 470
        height: 40
        Component.onCompleted: search.forceActiveFocus()
        color: Colors.md3.on_surface
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

        background: Rectangle {
            anchors.centerIn: parent
            radius: 15
            color: Colors.transparency(Colors.md3.surface_variant, 0.3)
            width: search.width + 80

            MaterialIcon {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
                name: "search"
                color: Colors.md3.inverse_on_surface
            }

        }

    }

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
        onCurrentIndexChanged: {
            Shellstate.wallpaperOld = Shellstate.wallpaper;
            Shellstate.wallpaper = WallpapersService.files[currentIndex];
        }

        delegate: ClippingRectangle {
            id: container

            required property var modelData

            width: 450
            height: width * 9 / 16
            scale: ListView.isCurrentItem ? 1 : 0.8
            color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)
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
                source: container.modelData
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
