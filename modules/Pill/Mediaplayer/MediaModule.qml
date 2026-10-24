import QtQuick
import Quickshell
import qs.Components

PillModule {
    id: module

    name: "mediaplayer"

    compact: Miniplayer {
        pill: module.pill
    }

    expanded: MediaPlayer {
        pill: module.pill
    }

}
