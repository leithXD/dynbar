import "../Pill/Mediaplayer/"
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
            implicitHeight: 50
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            exclusiveZone: 50
            WlrLayershell.namespace: "Bar"

            anchors {
                top: true
                right: true
                left: true
            }

            ClippingRectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 30
                width: 400
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)
            }

            ClippingRectangle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 30
                width: 400
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)

                Equalizer {
                    opacity: Shellstate.activePill !== "mediaplayer" ? 0.4 : 0
                    y: 40 / 2 + 4 - 4
                    scale: 1
                    width: 530
                    height: 40
                    barCount: 80

                    Smooth on opacity {
                    }

                }

            }

            mask: Region {
            }

        }

    }

}
