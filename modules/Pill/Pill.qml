import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Core
import "Clock"
import "Notification"
import "Mediaplayer"

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
            implicitHeight: 1080
            implicitWidth: 1920

            HyprlandFocusGrab {
                windows: root
                active: Shellstate.maximized !== false && Shellstate.activePill !== "notification"
                onCleared: Shellstate.maximized = false
            }

            ClippingRectangle {
                id: pillRect
                radius: 20
                width: {
                    if (Shellstate.maximized) {
                        if (Shellstate.activePill === "clock") return clock.width
                        if (Shellstate.activePill === "notification") return notifs.width
                        if (Shellstate.activePill === "mediaplayer") return mediaPlayer.width
                    } else {
                        if (Shellstate.activePill === "clock") return minClock.width
                        if (Shellstate.activePill === "notification") return notifs.width
                        if (Shellstate.activePill === "mediaplayer") return miniplayer.width
                    }
                    return 230
                }

                height: {
                    if (Shellstate.maximized) {
                        if (Shellstate.activePill === "clock") return clock.height
                        if (Shellstate.activePill === "notification") return notifs.height
                        if (Shellstate.activePill === "mediaplayer") return mediaPlayer.height
                    } else {
                        if (Shellstate.activePill === "clock") return minClock.height
                        if (Shellstate.activePill === "notification") return notifs.height
                        if (Shellstate.activePill === "mediaplayer") return miniplayer.height
                    }
                    return 38
                }
                scale: pillArea.pressed ? 1.05
                     : pillRect.hovered ? 1.02
                     : 1
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
                        // Let them do other stuff if maximized, i dont like it getting changed randomly
                        if (mouse.button === Qt.RightButton) {
                            Shellstate.cyclePill()
                        }
                        if (mouse.button === Qt.LeftButton) {
                            Shellstate.toggleMaximized()
                        }
                    }
                }

                Clock{
                    id: minClock
                    opacity: Shellstate.activePill === "clock" && !Shellstate.maximized ? 1 : 0
                    scale: Shellstate.activePill === "clock" && !Shellstate.maximized ? 1 : 1.2
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

                Miniplayer {
                    id: miniplayer
                    opacity: Shellstate.activePill === "mediaplayer" ? 1 : 0
                    scale: Shellstate.activePill === "mediaplayer" ? 1 : 1.2 //  && !Shellstate.maximized normally but ehh
                    Behavior on opacity{
                        NumberAnimation{
                            duration: 200
                            easing: Easing.OutBack
                        }
                    }
                    Behavior on scale{
                        NumberAnimation{
                            duration: 200
                            easing: Easing.OutBack
                        }
                    }
                }

                ClockPopout{
                    id: clock
                    opacity: Shellstate.activePill === "clock" && Shellstate.maximized ? 1 : 0
                    scale: Shellstate.activePill === "clock" && Shellstate.maximized ? 3 : 1
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

                MediaPlayer{
                    id: mediaPlayer
                    opacity: Shellstate.activePill === "mediaplayer" && Shellstate.maximized ? 1 : 0
                    scale: Shellstate.activePill === "mediaplayer" && Shellstate.maximized ? 1 : 0
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

                Notification{
                    id: notifs
                    scale: Shellstate.activePill === "notification" ? 1 : 0.5
                    opacity: Shellstate.activePill === "notification" ? 1 : 0
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
