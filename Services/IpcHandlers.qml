import Quickshell
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
    }
}
