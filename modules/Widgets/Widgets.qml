import M3Shapes
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "Widgets"
import qs.Core

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData

            WlrLayershell.namespace: "widgets"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            screen: modelData
            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"

            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }

            ClippingRectangle {
                visible: false
                width: 100
                height: 50
                radius: 10
                anchors.centerIn: parent
                color: Colors.surfaceColor

                AtAGlance {
                }

            }

        }

    }

}
