import QtQuick
import Quickshell
import qs.Components

PillModule {
    name: "clock"
    compact: Clock {}
    expanded: ClockPopout {}
}
