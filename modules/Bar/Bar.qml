import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
        id: root
        anchors {
            top: true
            right: true
            left: true
        }
        implicitHeight: 40
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.namespace: "Bar"
}
