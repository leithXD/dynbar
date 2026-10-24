import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    id: module

    name: "launcher"
    standalone: true

    expanded: Launcher {
        id: launcher

        pill: module.pill
    }

}
