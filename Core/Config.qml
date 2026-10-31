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

        }

    }

    component Appearance: JsonObject {
    }

    component Bar: JsonObject {
        property bool alwaysShowRam: false
    }

    component Pill: JsonObject {
    }

    component Launcher: JsonObject {
    }

    component Lock: JsonObject {
    }

    component Services: JsonObject {
    }

    component Paths: JsonObject {
        property string wallpaperPath: "/Pictures/Wallpapers"
    }

}
