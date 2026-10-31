import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    id: module

    name: "wallpaper"
    standalone: true

    expanded: Wallpaper {
        id: wallpaperSelection

        pill: module.pill
    }

}
