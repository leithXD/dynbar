import QtQuick
import Quickshell
import qs.Components
import qs.Core

FloatingWindow {
    id: win

    title: "Dynbar Settings"
    implicitWidth: 1200
    implicitHeight: 700
    visible: true
    onClosed: Shellstate.settingsOpened = false
    color: Colors.md3.surface

    ToggleButton {
        anchors.centerIn: parent
    }

}
