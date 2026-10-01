import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Components
import qs.Core

Item {
    id: root
    anchors.fill: parent
    property var player: Mpris.players.values[0] ?? null

    Text {
        anchors.centerIn: parent
        text: root.player.trackTitle
        color: Theme.text
    }

    ClippingRectangle {
        width: 28
        height: 28
        radius: 14
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        Image {
            width: 28
            height: 28
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
