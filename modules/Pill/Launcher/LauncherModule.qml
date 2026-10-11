import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    name: "launcher"
    standalone: true

    expanded: Launcher {
        id: launcher
    }

}
