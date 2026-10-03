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
        y: Shellstate.maximized ? 80 : root.implicitHeight / 2
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
        text: Format.cleanTitle(root.player?.trackTitle, root.player?.trackArtist)
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
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: Shellstate.maximized ? -20 : 5
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        Image {
            id: coverImage
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
            mipmap: true
            sourceSize: Qt.size(192, 192)
            antialiasing: true
            visible: status === Image.Ready
            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: 32000
                loops: Animation.Infinite
                running: player?.isPlaying ?? false
            }
        }
        MaterialLoading {
            loading: coverImage.status !== Image.Ready
            width: coverImage.width - 5
            height: coverImage.height - 5
        }
    }

    Timer {
        running: root.player && root.player.isPlaying
        interval: 500
        repeat: true
        onTriggered: root.player.positionChanged()
    }
}
