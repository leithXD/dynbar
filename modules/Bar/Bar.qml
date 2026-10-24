import "../Pill/Mediaplayer/"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Core

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData
            readonly property var pill: Shellstate.stateFor(modelData.name)
            readonly property string activePill: pill?.activePill ?? ""

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
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 30
                width: 400
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)
            }

            ClippingRectangle {
                id: rightPill

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 30
                width: 400
                height: 38
                radius: 30
                color: Colors.transparency(Colors.md3.surface, 0.8)

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

                RowLayout {
                    anchors.fill: parent
                    spacing: 5

                    Item {
                        Layout.fillWidth: true

                        Spring on Layout.preferredWidth {
                        }

                    }

                    Loader {
                        id: ram

                        active: true
                        Layout.preferredHeight: 38
                        Layout.preferredWidth: Math.max(0, slot)  

                        property real slot: item ? item.implicitWidth : 0

                        sourceComponent: StatChip {
                            icon: "memory_alt"
                            text: SysmonService.ramUsage
                            color: Colors.md3.tertiary
                            padding: 45
                        }

                        Spring on slot {
                        }

                    }

                    Loader {
                        id: cpu

                        active: true
                        Layout.preferredHeight: 38
                        Layout.preferredWidth: Math.max(0, slot)  

                        property real slot: item ? item.implicitWidth : 0

                        sourceComponent: StatChip {
                            icon: "memory"
                            text: SysmonService.cpuUsage
                            color: Colors.md3.tertiary
                        }

                        Spring on slot {
                        }

                    }

                    Loader {
                        id: playButtons

                        readonly property bool wanted: root.activePill !== "mediaplayer"
                        property real slot: wanted ? 62 : 0

                        active: wanted || slot > 0.5
                        
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: Math.max(0, slot)
 
                        sourceComponent: PlaybackButtons {
                            opacity: wanted ? 1 : 0
                            scale: wanted ? 1 : 0.1
                            Spring on scale {}

                            Spring on opacity {}


                        }

                        Spring on slot {
                        }

                    }

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
