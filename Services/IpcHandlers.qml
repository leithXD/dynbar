import Quickshell
import QtQuick
import Quickshell.Io
import qs.Core
import qs.Services

Scope {
    IpcHandler {
        target: "launcher"

        function toggle(): void {
            if (!Shellstate.focused()?.isFullscreen) {
                Shellstate.focused()?.toggleLauncher()
            }
        }
    }

    IpcHandler {
        target: "wallpaperSelection"

        function toggle(): void {
            if (!Shellstate.focused()?.isFullscreen) {
                Quickshell.execDetached(["dynbar", "wallpaper", "cache", WallpapersService.dir, WallpapersService.cache]);
                Shellstate.focused()?.toggleWallpaper()
            }
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
