import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Components
import qs.Core

Item {
    id: root
    implicitWidth: 350
    implicitHeight: 40
    property var player: Mpris.players.values[0] ?? null

    Equalizer {
        anchors.verticalCenter: parent.verticalCenter
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
        id: cover
        width: Shellstate.maximized ? 96 : 28
        height: Shellstate.maximized ? 96 : 28
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
        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 32000
            loops: Animation.Infinite
            running: player?.isPlaying ?? false
        }
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: Shellstate.maximized ? -20 : 5
        anchors.verticalCenter: parent.verticalCenter
        Image {
            width: Shellstate.maximized ? 96 : 28
            height: Shellstate.maximized ? 96 : 28
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
            source: player?.trackArtUrl ?? ""
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true
            sourceSize: Qt.size(128, 128)
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
