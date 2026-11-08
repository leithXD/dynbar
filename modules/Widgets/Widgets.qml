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

            WidgetModule {
                id: weather

                width: 200
                height: 70
                radius: 70
                shapeEnabled: false
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 20

                widget: WeatherWidget {
                    id: weather
                }

            }

        }

    }

}
