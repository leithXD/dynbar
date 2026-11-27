import M3Shapes
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "Widgets"
import qs.Components
import qs.Core
import qs.Services

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData

            WlrLayershell.namespace: "widgets"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            screen: modelData
            WlrLayershell.layer: WlrLayer.Bottom
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

            WidgetModule {
                id: cpu

                width: 200
                height: 200
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                shapeEnabled: true
                color: Colors.surfaceColor

                widget: CpuUsage {
                }

            }

            Loader {
                property bool wanted: MediaplayerService.isPlaying

                opacity: wanted ? 1 : 0.5
                active: anchors.bottomMargin !== -280
                anchors.left: parent.left
                anchors.leftMargin: 250
                anchors.bottom: parent.bottom
                anchors.bottomMargin: wanted ? 20 : -280

                Anim on opacity {
                    state: "smooth"
                }

                Anim on anchors.bottomMargin {
                }

                sourceComponent: WidgetModule {
                    id: lyrics

                    width: 400
                    height: 280
                    color: Colors.surfaceColor

                    widget: Lyrics {
                    }

                }

            }

        }

    }

}
