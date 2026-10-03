import QtQuick
import Quickshell
import qs.Components

PillModule {
    name: "mediaplayer"
    compact: Miniplayer {}
    expanded: MediaPlayer {}
    keepCompact: true
}
