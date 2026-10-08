import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import qs.Core
import qs.Components
import qs.Services
import "Clock"
import "Notification"
import "Mediaplayer"
import "Launcher"
import "VolumeSlider"

Scope {
    Variants {
        id: pills
        model: Quickshell.screens;

        delegate: Component {
                PanelWindow {
                    id: root
                    anchors.top: true
                    WlrLayershell.namespace: "dynbar"
                    WlrLayershell.keyboardFocus: needsFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
                    readonly property bool needsFocus: Shellstate.activePill === "launcher"
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
                        readonly property var modules: [clockModule, mediaModule, notifModule, volumeModule, launcherModule]
                        readonly property var current: modules.find(m => m.name === Shellstate.activePill)

                        width:  current && current.targetWidth  > 0 ? current.targetWidth  : 230
                        height: current && current.targetHeight > 0 ? current.targetHeight : 38
                        scale: pillArea.pressed ? 1.05
                            : pillRect.hovered || Shellstate.componentHover ? 1.02
                            : 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: Shellstate.activePill === "launcher" ? (root.height / 2) - 100 - Shellstate.launcherCount * 30 : 6
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
                        Spring on height{}
                        Spring on width{}

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

                            onWheel: (wheel) => {
                                if (!AudioService.sink?.ready || !AudioService.sink.audio) return

                                const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                                AudioService.sink.audio.volume = Math.max(0, Math.min(1.0, AudioService.sink.audio.volume + step))
                                wheel.accepted = true
                            }
                        }

                        ClockModule { id: clockModule }
                        MediaModule { id: mediaModule }
                        NotificationModule { id: notifModule }
                        VolumeSliderModule { id: volumeModule }
                        LauncherModule { id: launcherModule }
                    }
                }
            }
        }

    HyprlandFocusGrab {
        windows: pills.instances
        active: Shellstate.maximized && Shellstate.returnPill === "" || Shellstate.activePill === "launcher"
        onCleared: Shellstate.maximized = false
    }
}
