import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root
    implicitWidth: 350
    implicitHeight: 40

    Equalizer {
        y: root.implicitHeight / 2 + 4
        scale: 1
        Behavior on scale{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        width: root.width
        height: root.height
        barCount: 40
        opacity: 0.4
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        font.weight: Font.DemiBold
        width: 280
        text: Format.cleanTitle(MediaplayerService.trackTitle, MediaplayerService.trackArtist)
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 1
        color: Theme.text
    }

    ClippingRectangle {
        id: cover
        width: 28
        height: 28
        Behavior on width{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        Behavior on height{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        Image {
            id: coverImage
            width: 28
            height: 28
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
                duration: 32000
                loops: Animation.Infinite
                running: MediaplayerService.isPlaying
            }
        }
        MaterialLoading {
            loading: coverImage.status !== Image.Ready
            width: coverImage.width - 5
            height: coverImage.height - 5
            opacity: MediaplayerService.hasPlayer ? 1 : 0
            Spring on opacity{}
        }
    }
}
