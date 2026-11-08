import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    property alias appearance: jsonAdapter.appearance
    property alias bar: jsonAdapter.bar
    property alias pill: jsonAdapter.pill
    property alias launcher: jsonAdapter.launcher
    property alias lock: jsonAdapter.lock
    property alias services: jsonAdapter.services
    property alias paths: jsonAdapter.paths
    property alias settings: jsonAdapter.settings

    FileView {
        path: Quickshell.env("HOME") + "/.config/dynbar/shell.json"
        watchChanges: true
        blockLoading: true
        onFileChanged: reload()

        JsonAdapter {
            id: jsonAdapter

            readonly property Appearance
            appearance: Appearance {
            }

            readonly property Bar
            bar: Bar {
            }

            readonly property Pill
            pill: Pill {
            }

            readonly property Launcher
            launcher: Launcher {
            }

            readonly property Lock
            lock: Lock {
            }

            readonly property Services
            services: Services {
            }

            readonly property Paths
            paths: Paths {
            }

            readonly property Settings
            settings: Settings {
            }

        }

    }

    component Appearance: JsonObject {
        property bool transparency: true
        property real surfaceOpacity: 0.8
        property real layerOpacity: 0.3
    }

    component Bar: JsonObject {
        property bool alwaysShowRam: false
        property bool alwaysShowTemp: false
        property bool floating: true
    }

    component Pill: JsonObject {
        property bool floating: true
        property bool blurArtwork: false
    }

    component Launcher: JsonObject {
        property bool launcherBgBlur: false
    }

    component Lock: JsonObject {
    }

    component Services: JsonObject {
        property string weatherLocation: "Berlin"
    }

    component Paths: JsonObject {
        property string wallpaperPath: "/Pictures/Wallpapers"
    }

    component Settings: JsonObject {
        property bool toastsFullscreen: true
        property int tempWarning: 90
    }

}
