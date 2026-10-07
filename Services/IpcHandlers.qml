import Quickshell
import QtQuick
import Quickshell.Io
import qs.Core

Scope {
    IpcHandler {
        target: "launcher"
        function toggle(): void { Shellstate.toggleLauncher() }
    }

    IpcHandler {
        target: "pill"
        function cycle(): void { Shellstate.cyclePill() }
        function maximize(): void { Shellstate.toggleMaximized() }
        function show(name: string): void { Shellstate.activePill = name }
        function peek(name: string): void {
            Shellstate.togglePill(name)
            delay.running = true
        }
    }

    Timer {
        id: delay
        interval: 2000
        onTriggered: {
            let current = Shellstate.activePill
            Shellstate.activePill = Shellstate.oldPill
            Shellstate.oldPill = current
        }
        running: false
    }
}
