import QtQuick
import Quickshell
import qs.Components

PillModule {
    id: module

    name: "clock"

    compact: Clock {
    }

    expanded: ClockPopout {
        pill: module.pill
    }

}
