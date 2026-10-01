pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property string activeMode: "none"
    property string activePill: "clock"

    function toggleMode(mode) {
        if (activeMode === mode) {
            activeMode = "none"
        } else {
            activeMode = mode
        }
    }

    function togglePill(mode) {
        activePill = mode
    }
}
