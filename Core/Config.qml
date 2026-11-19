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
    // models here
    // bar model
    readonly property var barModel: [{
        "title": "Bar floating",
        "desc": "Should the bar be floating?",
        "targetProperty": "floating",
        "type": "toggle"
    }, {
        "title": "Show temperature",
        "desc": "Always show Cpu temperature on Bar?",
        "targetProperty": "alwaysShowTemp",
        "type": "toggle"
    }, {
        "title": "Show ram",
        "desc": "ALways show ram usage on bar?",
        "targetProperty": "alwaysShowRam",
        "type": "toggle"
    }]
    // pill model
    readonly property var pillModel: [{
        "title": "Pill floating",
        "desc": "Should the pill be floating?",
        "targetProperty": "floating",
        "type": "toggle"
    }, {
        "title": "Cover Art",
        "desc": "Show blurred artwork on Pill?",
        "targetProperty": "blurArtwork",
        "type": "toggle"
    }]
    // services model
    readonly property var servicesModel: [{
        "title": "Weather location",
        "desc": "Where are you located?",
        "targetProperty": "weatherLocation",
        "type": "input"
    }]
    // appearance model
    readonly property var appearanceModel: [{
        "title": "Transparency",
        "desc": "Should the shell be transparent?",
        "targetProperty": "transparency",
        "type": "toggle"
    }, {
        "title": "Transparency layer",
        "desc": "How transparent should the layers be?",
        "targetProperty": "layerOpacity",
        "type": "slider"
    }, {
        "title": "Transparency surface",
        "desc": "How transparent should the surface be?",
        "targetProperty": "surfaceOpacity",
        "type": "slider"
    }]

    function saveSettings() {
        config.writeAdapter();
    }

    FileView {
        id: config

        path: Quickshell.env("HOME") + "/.config/dynbar/shell.json"
        watchChanges: true
        blockLoading: true
        onFileChanged: reload()
        onLoadFailed: (error) => {
            if (error === FileViewError.FileNotFound)
                writeAdapter();

        }

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
