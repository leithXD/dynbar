import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs.Core

Item {
    id: root
    implicitWidth: 420
    implicitHeight: 160
    property var player: Mpris.players.values[0] ?? null
    // i think ill just let the miniplayer be enabled for smoother transition and then leave some components here like player stuff, author names and yea
}
