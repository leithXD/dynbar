import "Components"
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Core

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData

            screen: modelData
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            exclusiveZone: 50
            WlrLayershell.layer: Config.settings.toastsFullscreen ? WlrLayer.Overlay : WlrLayer.Top
            WlrLayershell.namespace: "overlays"

            anchors {
                top: true
                right: true
                bottom: true
                left: true
            }

            Toasts {
                id: toastMask
            }

            ClippingRectangle {
                id: mainOverlay

                property bool active: false

                width: clipboard.implicitWidth
                height: clipboard.implicitHeight
                radius: 30
                color: Colors.surfaceColor
                y: active ? (screen.height - height) / 2 : screen.height - 50
                x: (screen.width - width) / 2

                Clipboard {
                    id: clipboard

                    anchors.centerIn: parent
                }

                Spring on y {
                }

            }

            mask: Region {
                item: toastMask

                Region {
                    item: mainOverlay
                }

            }

        }

    }

}
