import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Components
import qs.Core

Item {
    id: root
    width: 350
    height: 40
    anchors.centerIn: parent
    property var player: Mpris.players.values[0] ?? null
    property int realHeight: parent.height

    Equalizer {
        y: root.realHeight / 2 + 2
        scale: Shellstate.maximized ? 1.5 : 1
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
        anchors.centerIn: parent
        text: root.player.trackTitle
        color: Theme.text
    }

    ClippingRectangle {
        width: 28
        height: 28
        scale: Shellstate.maximized ? 3 : 1
        Behavior on scale{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        Image {
            scale: Shellstate.maximized ? 3 : 1
            Behavior on scale{
                NumberAnimation{
                    duration: 200
                    easing: Easing.OutBack
                }
            }
            width: Shellstate.maximized ? 64 : 28
            height: Shellstate.maximized ? 64 : 28
            source: player?.trackArtUrl ?? ""
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true
            sourceSize: Qt.size(width * 2, height * 2)
            visible: status === Image.Ready
        }
    }

    Timer {
        running: root.player && root.player.isPlaying
        interval: 500
        repeat: true
        onTriggered: root.player.positionChanged()
    }
}
