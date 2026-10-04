import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Core
import qs.Components
import qs.Services

Item {
    id: root
    implicitWidth: 700
    implicitHeight: 190
    // i think ill just let the miniplayer be enabled for smoother transition and then leave some components here like player stuff, author names and yea

    Equalizer {
        y: 105
        Behavior on scale{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        width: root.width
        height: root.height
        barCount: 70
        opacity: 0.2
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 210
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 320
        font.weight: Font.DemiBold
        text: Format.cleanTitle(MediaplayerService.trackTitle, MediaplayerService.trackArtist)
        color: Theme.text
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 1
        scale: 1.3
    }

    ClippingRectangle {
        id: cover
        width: 128
        height: 128
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        Image {
            id: coverImage
            width: cover.width
            height: cover.height
            source: MediaplayerService.trackArtUrl
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true
            mipmap: true
            sourceSize: Qt.size(192, 192)
            antialiasing: true
            visible: status === Image.Ready
            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: 55000
                loops: Animation.Infinite
                running: MediaplayerService.isPlaying
            }
        }
        MaterialLoading {
            loading: coverImage.status !== Image.Ready
            width: coverImage.width - 5
            height: coverImage.height - 5
            spacing: 40
        }
    }

    Item {
        height: 20
        width: 300
        anchors.left: parent.left
        anchors.leftMargin: 170
        anchors.top: parent.top
        anchors.topMargin: 130
        WavyProgress {
            anchors.centerIn: parent
            scale: 3
            progress: seekArea.pressed ? seekArea.dragProgress : MediaplayerService.progress
            animated: MediaplayerService.isPlaying
            smoothProgress: !seekArea.pressed
        }
        MouseArea {
            id: seekArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            property real dragProgress: 0

            function update(x) { dragProgress = Math.max(0, Math.min(1, x / width)); }

            onPressed: mouse => update(mouse.x)
            onPositionChanged: mouse => update(mouse.x)
            onReleased: MediaplayerService.seekTo(dragProgress)
        }
    }
}
