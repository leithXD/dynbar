import QtQuick
import Quickshell
import qs.Core
import qs.Services

Scope {
    id: root

    required property string screenName
    property bool maximized: false
    property string activePill: "clock"
    property string oldPill: "clock"
    property var allPills: ["clock", "mediaplayer"]
    property bool outLauncher: false
    property string returnPill: ""
    property bool returnMaximized: false
    property bool componentHover: false
    property int launcherCount: 0
    readonly property bool canGrabAttention: activePill !== "launcher" && !maximized
    readonly property bool wantsGrab: (maximized && returnPill === "") || activePill === "launcher"

    function toggleMaximized() {
        maximized = !maximized;
    }

    function togglePill(name) {
        if (activePill !== name && allPills.includes(name)) {
            oldPill = activePill;
            activePill = name;
        }
    }

    function cyclePill() {
        const i = allPills.indexOf(activePill);
        togglePill(allPills[(i + 1) % allPills.length]);
    }

    function peek(name) {
        togglePill(name);
        peekTimer.restart();
    }

    function showTransient(name) {
        if (returnPill === "") {
            returnPill = activePill;
            returnMaximized = maximized;
        }
        activePill = name;
    }

    function dismissTransient() {
        if (returnPill === "")
            return ;

        activePill = returnPill;
        maximized = returnMaximized;
        returnPill = "";
    }

    function toggleLauncher() {
        if (activePill === "launcher") {
            outLauncher = true;
            dismissTransient();
            dismissAnim.running = false;
            dismissAnim.running = true;
        } else {
            outLauncher = false;
            showTransient("launcher");
        }
    }

    Component.onCompleted: Shellstate.register(root)
    Component.onDestruction: Shellstate.unregister(root)

    Timer {
        id: dismissAnim

        interval: 300
        onTriggered: root.outLauncher = false
    }

    Timer {
        id: peekTimer

        interval: 2000
        onTriggered: {
            const current = root.activePill;
            root.activePill = root.oldPill;
            root.oldPill = current;
        }
    }

    Connections {
        function onIsPlayingChanged() {
            if (MediaplayerService.isPlaying && root.canGrabAttention)
                root.togglePill("mediaplayer");

        }

        function onActivePlayerChanged() {
            if (MediaplayerService.activePlayer === null && root.canGrabAttention)
                root.togglePill("clock");

        }

        target: MediaplayerService
    }

}
