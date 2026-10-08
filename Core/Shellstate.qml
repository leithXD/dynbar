pragma Singleton
import Quickshell
import QtQuick
import qs.Services

Singleton {
    property bool maximized: false
    property string activePill: "clock"
    property string oldPill: "clock"
    property string currentWallpaper: "/home/leith/Pictures/Wallpapers/peak/BotanicGardenJapan.png" // hardcoded rn
    property var allPills: ["clock", "mediaplayer"]
    property bool outLauncher: false
    property bool canGrabAttention: activePill !== "launcher" && activePill !== "notification" && !maximized // if pill isnt maximized or hight priority stuff like notifs and launcher is displayed you may do as you like

    property string returnPill: ""
    property bool returnMaximized: false
    property bool componentHover: false

    function debug() {
        console.log(".")
    }

    function toggleMaximized() {
        maximized = !maximized
    }

    function togglePill(name) {
        if (Shellstate.activePill !== name) {
            if (allPills.includes(name)) {
                Shellstate.oldPill = Shellstate.activePill
                Shellstate.activePill = name
            }
        }
    }

    function cyclePill() {
        const i = allPills.indexOf(activePill)
        togglePill(allPills[(i + 1) % allPills.length])
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

    Timer{
        id: dismissAnim
        interval: 300
        onTriggered: {
            outLauncher = false
        }
        running: false
    }

    function toggleLauncher() {
        if (activePill === "launcher") {
            outLauncher = true
            dismissTransient()
            dismissAnim.running = false
            dismissAnim.running = true
        }
        else {
            outLauncher = false
            showTransient("launcher")
        }
    }

    Connections {
        target: MediaplayerService
        function onIsPlayingChanged() {
            if (MediaplayerService.isPlaying && canGrabAttention) {
                togglePill("mediaplayer")
            }
        }

        function onActivePlayerChanged() {
            if (MediaplayerService.activePlayer === null && canGrabAttention) {
                togglePill("clock")
            }
        }
    }
}
