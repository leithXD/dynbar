pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property bool maximized: false
    property string oldPill: "clock"
    property string activePill: "clock"
    property var allPills: ["clock", "mediaplayer", "notification", "launcher"]
    property int currentPill: 0

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

    function cyclePill() {
        currentPill = (currentPill + 1) % allPills.length
        activePill = allPills[currentPill]
    }
}
