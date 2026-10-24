import Quickshell
import QtQuick
import Quickshell.Io
import qs.Core

Scope {
    IpcHandler {
        target: "launcher"

        function toggle(): void {
            Shellstate.focused()?.toggleLauncher()
        }
    }

    IpcHandler {
        target: "pill"

        function cycle(): void {
            Shellstate.focused()?.cyclePill()
        }

        function maximize(): void {
            Shellstate.focused()?.toggleMaximized()
        }

        function show(name: string): void {
            const p = Shellstate.focused()
            if (p)
                p.activePill = name
        }

        function peek(name: string): void {
            Shellstate.focused()?.peek(name)
        }
    }
}
