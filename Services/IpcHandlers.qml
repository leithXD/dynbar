import Quickshell
import QtQuick
import Quickshell.Io
import qs.Core
import qs.Services

Scope {
    IpcHandler {
        target: "launcher"

        function toggle(mode: string): void {
            if (!Shellstate.focused()?.isFullscreen) {
                Shellstate.focused()?.toggleLauncher(mode)
            }
        }
    }

    IpcHandler {
        target: "file"

        function received(file: string, fileType: string): void {
            Shellstate.localsendImages.append({
                file: file,
                fileType: fileType
            })
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

    IpcHandler {
        target: "toasts"
        function create(name: string, desc: string, icon: string): void {
            Shellstate.createToast(name, desc, icon)
        }
    }
}
