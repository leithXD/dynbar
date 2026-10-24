import "../Pill/Mediaplayer/"
import QtQuick
import QtQuick.Layouts
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
            readonly property var pill: Shellstate.stateFor(modelData.name)

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
                    opacity: pill.activePill !== "mediaplayer" ? 0.4 : 0
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
                    spacing: 0

                    Item {
                        Layout.fillWidth: true

                        Spring on Layout.preferredWidth {
                        }

                    }

                    Loader {
                        id: cpu

                        active: true
                        Layout.preferredHeight: 38
                        Layout.preferredWidth: 40

                        sourceComponent: Rectangle {
                            color: "white"
                        }

                        Spring on Layout.preferredWidth {
                        }

                    }

                    Loader {
                        id: playButtons

                        readonly property bool wanted: root.pill?.activePill !== "mediaplayer"
                        property real animWidth: wanted ? 70 : 0

                        active: wanted || animWidth > 0.5
                        
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: Math.max(0, animWidth)
 
                        sourceComponent: PlaybackButtons {
                            opacity: wanted ? 1 : 0
                            scale: wanted ? 1 : 0.2
                            Spring on scale {}

                            Spring on opacity {}


                        }

                        Spring on animWidth {
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
