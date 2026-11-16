import QtQuick
import Quickshell
import Quickshell.Wayland
import "modules/Bar"
import "modules/Lock"
import "modules/Overlays"
import "modules/Pill"
import "modules/Settings"
import "modules/SidePanel"
import "modules/Wallpaper"
import "modules/Widgets"
import qs.Core
import qs.Services

ShellRoot {
    LazyLoader {
        activeAsync: Shellstate.wallpaperLoaderEnabled

        WallpaperLayer {
        }

    }

    Loader {
        active: Shellstate.settingsOpened

        sourceComponent: Settings {
        }

    }

    Widgets {
    }

    Bar {
    }

    Pill {
    }

    SidePanel {
    }

    Overlays {
    }

    Lock {
    }

    IpcHandlers {
    }

}
