import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Core
import qs.Components
import "Clock"
import "Notification"
import "Mediaplayer"
import "Launcher"

Scope {
    Variants {
        id: pills
        model: Quickshell.screens;

        delegate: Component {
                PanelWindow {
                    id: root
                    anchors.top: true
                    WlrLayershell.namespace: "dynbar"
                    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
                    WlrLayershell.exclusiveZone: -1
                    required property var modelData
                    screen: modelData
                    mask: Region {
                        item: pillRect
                    }
                    color: "transparent"
                    implicitHeight: 1080
                    implicitWidth: 1920

                    ClippingRectangle {
                        id: pillRect
                        readonly property var modules: [clockModule, mediaModule, notifModule, launcherModule]
                        readonly property var current: modules.find(m => m.name === Shellstate.activePill)

                        width:  current && current.targetWidth  > 0 ? current.targetWidth  : 230
                        height: current && current.targetHeight > 0 ? current.targetHeight : 38
                        scale: pillArea.pressed ? 1.05
                            : pillRect.hovered || Shellstate.componentHover ? 1.02
                            : 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: Shellstate.activePill === "launcher" ? 150 : 6
                        color: Theme.transparency(Theme.surface, 0.8)
                        clip: true
                        radius: 20

                        Spring on anchors.topMargin{}

                        property bool hovered: false
                        property bool activated: false
                        property real maxRadius: 4
                        property real resistance: 5

                        transform: Translate {
                            id: t
                            Behavior on x { enabled: !pillArea.pressed; NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                            Behavior on y { enabled: !pillArea.pressed; NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                        }

                        Spring on scale{duration: 200}
                        Spring on height{
                            easing: Shellstate.isLauncher ? Easing.InOutCubic : Easing.OutBack
                        }
                        Spring on width{
                            easing: Shellstate.isLauncher ? Easing.InOutCubic : Easing.OutBack
                        }

                        MouseArea {
                            id: pillArea
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onEntered: {
                                pillRect.hovered = true
                            }
                            onExited: {
                                pillRect.hovered = false
                            }

                            property point start

                            onPressed: (m) => start = mapToItem(null, m.x, m.y)

                            onPositionChanged: (m) => {
                                if (!pressed) return
                                const p  = mapToItem(null, m.x, m.y)
                                const dx = p.x - start.x
                                const dy = p.y - start.y
                                const d  = Math.hypot(dx, dy)
                                if (d === 0) return

                                const k = pillRect.maxRadius * Math.tanh(d / (pillRect.maxRadius * pillRect.resistance)) / d
                                t.x = dx * k
                                t.y = dy * k
                            }

                            onReleased: { t.x = 0; t.y = 0 }

                            onClicked: function(mouse) {
                                // Let them do other stuff if maximized, i dont like it getting changed randomly
                                if (mouse.button === Qt.RightButton) {
                                    Shellstate.cyclePill()
                                }
                                if (mouse.button === Qt.LeftButton) {
                                    Shellstate.debug() // (debug) i use this for trying out whats inside a variable
                                    Shellstate.toggleMaximized()
                                }
                            }
                        }

                        ClockModule { id: clockModule }
                        MediaModule { id: mediaModule }
                        NotificationModule { id: notifModule }
                        LauncherModule { id: launcherModule }
                    }
                }
            }
        }

    HyprlandFocusGrab {
        windows: pills.instances
        active: Shellstate.maximized && Shellstate.returnPill === ""
        onCleared: Shellstate.maximized = false
    }
}
