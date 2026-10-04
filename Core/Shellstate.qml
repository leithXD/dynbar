pragma Singleton
import Quickshell
import QtQuick
import qs.Services

Singleton {
    property bool maximized: false
    property string activePill: "clock"
    property string currentWallpaper: "/home/leith/Pictures/Wallpapers/peak/BotanicGardenJapan.png" // hardcoded rn
    property var allPills: ["clock", "mediaplayer"]

    property string returnPill: ""
    property bool returnMaximized: false
    property bool componentHover: false

    function toggleMaximized() {
        maximized = !maximized
    }

    function cyclePill() {
        const i = allPills.indexOf(activePill)
        activePill = allPills[(i + 1) % allPills.length]
    }

    function showTransient(name) {
        if (returnPill === "") { returnPill = activePill; returnMaximized = maximized }
        activePill = name
    }

    function dismissTransient() {
        if (returnPill === "") return
        activePill = returnPill
        maximized = returnMaximized
        returnPill = ""
    }

    Connections {
        target: MediaplayerService
        function onIsPlayingChanged() {
            if (MediaplayerService.isPlaying) {
                Shellstate.oldPill = Shellstate.activePill
                Shellstate.activePill = "mediaplayer"
            }
        }

        function onActivePlayerChanged() {
            if (MediaplayerService.activePlayer === null) {
                Shellstate.activePill = "clock"
            }
        }
    }
}
