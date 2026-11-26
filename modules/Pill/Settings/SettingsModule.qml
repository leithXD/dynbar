import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    id: module

    name: "settings"
    standalone: true

    expanded: Settings {
        id: settings

        pill: module.pill
    }

}
