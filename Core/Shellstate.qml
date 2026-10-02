pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property bool maximized: false
    property string oldPill: "clock"
    property string activePill: "clock"

    function toggleMaximized() {
        maximized = !maximized
    }

    function togglePill(mode) {
        if (oldPill !== "notification") {
            oldPill = activePill
            activePill = mode
        }
    }

    function rememberPill() {
        oldPill = activePill
    }
}
