pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property string activeMode: "none"

    function toggleMode(mode) {
        if (activeMode === mode) {
            activeMode = "none"
        } else {
            activeMode = mode
        }
    }
}
