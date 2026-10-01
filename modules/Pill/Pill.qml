import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Core
import "Clock"
import "ClockPopout"
import "Notification"

Variants {
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
            implicitHeight: 600
            implicitWidth: 600


            HyprlandFocusGrab {
                windows: root
                active: Shellstate.activeMode !== "none" && Shellstate.activeMode !== "notification"
                onCleared: Shellstate.activeMode = "none"
            }

            Rectangle {
                id: pillRect
                radius: 20
                width: {
                    if (Shellstate.activeMode === "clock") return clock.width
                    if (Shellstate.activeMode === "notification") return notifs.width
                    return 230
                }

                height: {
                    if (Shellstate.activeMode === "clock") return clock.height
                    if (Shellstate.activeMode === "notification") return notifs.height
                    return 38
                }
                scale: pillArea.pressed ?  1.04 : 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 6
                color: Theme.transparency(Theme.surface, 0.8)
                clip: true

                property bool hovered: false
                property bool activated: false
                property real maxRadius: 4
                property real resistance: 5

                transform: Translate {
                    id: t
                    Behavior on x { enabled: !pillArea.pressed; NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                    Behavior on y { enabled: !pillArea.pressed; NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                }

                Behavior on scale{
                    NumberAnimation{
                        duration: 200
                        easing: Easing.OutBack
                    }
                }
                Behavior on height{
                    NumberAnimation{
                        duration: 300
                        easing: Easing.OutBack
                    }
                }
                Behavior on width{
                    NumberAnimation{
                        duration: 300
                        easing: Easing.OutBack
                    }
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
                        if (mouse.button === Qt.RightButton) {
                            Shellstate.toggleMode("notification")
                        }
                        if (mouse.button === Qt.LeftButton) {
                            Shellstate.toggleMode("clock")
                        }
                    }
                }

                Clock{
                    opacity: Shellstate.activeMode === "none" ? 1 : 0
                    scale: Shellstate.activeMode === "none" ? 1 : 1.2
                    Behavior on opacity{
                        NumberAnimation{
                            duration: 300
                            easing: Easing.OutBack
                        }
                    }
                    Behavior on scale{
                        NumberAnimation{
                            duration: 300
                            easing: Easing.OutBack
                        }
                    }
                }

                ClockPopout{
                    id: clock
                    opacity: Shellstate.activeMode === "clock" ? 1 : 0
                    scale: Shellstate.activeMode === "clock" ? 3 : 1
                    Behavior on opacity{
                        NumberAnimation{
                            duration: 400
                            easing: Easing.OutBack
                        }
                    }
                    Behavior on scale{
                        NumberAnimation{
                            duration: 400
                            easing: Easing.OutBack
                        }
                    }
                }
                Notification{
                    id: notifs
                    scale: Shellstate.activeMode === "notification" ? 1 : 0.5
                    opacity: Shellstate.activeMode === "notification" ? 1 : 0
                    Behavior on scale{
                        NumberAnimation{
                            duration: 300
                            easing: Easing.OutBack
                        }
                    }
                    Behavior on opacity{
                        NumberAnimation{
                            duration: 300
                            easing: Easing.OutBack
                        }
                    }
                }
            }
        }
    }
}
