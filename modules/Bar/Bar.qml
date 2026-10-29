import "../Pill/Mediaplayer/"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Core
import "RightPill"
import "Workspaces"

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData
            readonly property var pill: Shellstate.stateFor(modelData.name)
            readonly property string activePill: pill?.activePillReal ?? ""

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
                id: leftPill

                anchors.left: parent.left
                y: root.pill.isFullscreen ? -50 : 6
                anchors.leftMargin: root.pill.isFullscreen ? -20 : 30
                property int padding: 10
                width: workspaces.implicitWidth + padding
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)
                Spring on y{}
                Spring on anchors.leftMargin {}
                Workspaces {
                    id: workspaces

                }
            }

            ClippingRectangle {
                id: rightPill

                anchors.right: parent.right
                y: root.pill.isFullscreen ? -50 : 6
                anchors.rightMargin:  root.pill.isFullscreen ? -20 : 30
                width: row.implicitWidth
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)
                Spring on width {
                    duration: 100
                }
                Spring on y {}
                Spring on anchors.rightMargin {}

                Equalizer {
                    opacity: root.activePill !== "mediaplayer" ? 0.4 : 0
                    y: 40 / 2 + 4 - 4
                    scale: 1
                    width: 530
                    height: 40
                    barCount: 80

                    Smooth on opacity {
                    }

                }

                RightPill {
                    id: row
                    activePill: root.activePill
                }
            }

            mask: Region {
                item: leftPill

                Region {
                    item: rightPill
                }

            }

        }

    }

}
