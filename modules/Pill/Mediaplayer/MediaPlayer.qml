import QtQuick
import Quickshell
import qs.Core

Item {
    id: root
    width: 420
    height: 160
    anchors.centerIn: parent
    property var player: Mpris.players.values[0] ?? null
    // i think ill just let the miniplayer be enabled for smoother transition and then leave some components here like player stuff, author names and yea
}
