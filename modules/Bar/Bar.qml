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
                anchors.top: parent.top
                property int padding: 10
                width: workspaces.implicitWidth + padding
                height: 38
                radius: 30
                color: Colors.surface(Colors.md3.surface)
                Spring on anchors.leftMargin {}
                Spring on anchors.topMargin {}

                states: [
                    State {
                        name: "fullscreen_docked"
                        when: root.pill.isFullscreen && !Config.bar.floating
                        PropertyChanges {
                            target: leftPill
                            anchors.leftMargin: -100
                            anchors.topMargin: -50
                            topLeftRadius: 0
                            topRightRadius: 0 
                            bottomLeftRadius: 0
                        }
                    },

                    State {
                        name: "fullscreen_floating"
                        when: root.pill.isFullscreen && Config.bar.floating
                        PropertyChanges {
                            target: leftPill
                            anchors.leftMargin: -100
                            anchors.topMargin: -50
                        }
                    },

                    State {
                        name: "docked"
                        when: !Config.bar.floating
                        PropertyChanges {
                            target: leftPill
                            topRightRadius: 0
                            topLeftRadius: 0 
                            bottomLeftRadius: 0
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                        }
                    },
                    State {
                        name: "floating"
                        when: Config.bar.floating
                        PropertyChanges {
                            target: leftPill
                            anchors.leftMargin: 30
                            anchors.topMargin: 6
                        }
                    }
                ]

                Workspaces {
                    id: workspaces

                }
            }

            ClippingRectangle {
                id: rightPill

                anchors.right: parent.right
                anchors.top: parent.top
                width: row.implicitWidth
                height: 38
                radius: 30
                color: Colors.surface(Colors.md3.surface)
                Spring on width {
                    duration: 100
                }
                Spring on anchors.rightMargin {}
                Spring on anchors.topMargin {} 
                states: [
                    State {
                        name: "fullscreen_docked"
                        when: root.pill.isFullscreen && !Config.bar.floating
                        PropertyChanges {
                            target: rightPill
                            anchors.rightMargin: -100
                            anchors.topMargin: -50
                            topRightRadius: 0
                            topLeftRadius: 0 
                            bottomRightRadius: 0
                        }
                    },

                    State {
                        name: "fullscreen_floating"
                        when: root.pill.isFullscreen && Config.bar.floating
                        PropertyChanges {
                            target: rightPill
                            anchors.rightMargin: -100
                            anchors.topMargin: -50
                        }
                    },

                    State {
                        name: "docked"
                        when: !Config.bar.floating
                        PropertyChanges {
                            target: rightPill
                            topRightRadius: 0
                            topLeftRadius: 0 
                            bottomRightRadius: 0
                            anchors.rightMargin: 0
                            anchors.topMargin: 0
                        }
                    },
                    State {
                        name: "floating"
                        when: Config.bar.floating
                        PropertyChanges {
                            target: rightPill
                            anchors.rightMargin: 30
                            anchors.topMargin: 6
                        }
                    }
                ]


                Loader {
                    active: true
                    sourceComponent: Equalizer {
                        opacity: root.activePill !== "mediaplayer" ? 0.4 : 0
                        y: 40 / 2 + 4 - 4
                        scale: 1
                        width: 530
                        height: 40
                        barCount: 80

                        Smooth on opacity {
                        }

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
