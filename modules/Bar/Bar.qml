import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
  model: Quickshell.screens;

  delegate: Component {
        PanelWindow {
                id: root
                required property var modelData
                screen: modelData
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
    }
}
