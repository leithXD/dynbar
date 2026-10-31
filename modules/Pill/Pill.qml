import QtQuick
import QtQuick.Effects
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
import "Wallpaper"

Scope {
    readonly property var grabWindows: pills.instances.filter(w => w.wantsGrab)

    Variants {
        id: pills

        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: root

                required property var modelData
                readonly property bool needsFocus: pillState.activePill === "launcher"
                readonly property bool wantsGrab: pillState.wantsGrab
                readonly property bool blurActive: pillState.activePill === "launcher"
                readonly property int screenIndex: {
                    for (let i = 0; i < Quickshell.screens.length; i++) {
                        if (Quickshell.screens[i] === modelData) return i;
                    }
                    return 0;
                }

                Loader {
                    id: launcherBg
                    anchors.fill: parent
                    active: false // make configurable ig
                    sourceComponent: Component {
                        Item {
                            anchors.fill: parent
                            ScreencopyView {
                                id: screenCopy
                                anchors.fill: parent
                                captureSource: (root.blurActive || blurredBg.opacity > 0) ? (Quickshell.screens.length > 0 ? Quickshell.screens[root.screenIndex] : null) : null
                                visible: false
                            }

                            MultiEffect {
                                id: blurredBg

                                anchors.fill: screenCopy
                                source: screenCopy
                                blurEnabled: true
                                blur: root.blurActive ? 1 : 0.2
                                opacity: root.blurActive ? 1 : 0
                                blurMax: 64
                                blurMultiplier: 1
                                autoPaddingEnabled: false
                                visible: blur > 0.3

                                Behavior on blur {
                                    NumberAnimation {
                                        duration: 600
                                        easing.type: Easing.OutCubic
                                    }

                                }

                                Smooth on opacity {
                                    duration: 200
                                }

                            }

                        }
                    }

                }


                screen: modelData
                anchors.top: true
                WlrLayershell.namespace: "dynbar"
                WlrLayershell.keyboardFocus: needsFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
                WlrLayershell.exclusiveZone: -1
                color: "transparent"
                implicitHeight: 1080
                implicitWidth: 1920

                mask: Region {
                    item: pillRect
                }

                PillState {
                    id: pillState

                    screenName: root.modelData.name
                }

                ClippingRectangle {
                    id: pillRect

                    readonly property var modules: [clockModule, mediaModule, notifModule, volumeModule, launcherModule, wallpaperModule]
                    readonly property var current: modules.find(m => m.name === pillState.activePill)
                    property bool hovered: false
                    property bool activated: false
                    property real maxRadius: 4
                    property real resistance: 5

                    width: current && current.targetWidth > 0 ? current.targetWidth : 230
                    height: current && current.targetHeight > 0 ? current.targetHeight : 38
                    scale: pillArea.pressed ? 1.05 : pillRect.hovered || pillState.componentHover ? 1.02 : 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: pillState.isFullscreen ? -50 : (pillState.activePill === "launcher" ? (root.height / 2) - 100 - pillState.launcherCount * 30 : 6)
                    color: Colors.transparency(Colors.md3.surface, 0.8)
                    clip: true
                    radius: 20

                    transform: Translate {
                        id: t

                        Behavior on x {
                            enabled: !pillArea.pressed

                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }

                        }

                        Behavior on y {
                            enabled: !pillArea.pressed

                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }

                        }

                    }

                    Spring on anchors.topMargin {
                    }

                    Spring on scale {
                        duration: 200
                    }

                    Spring on height {
                    }

                    Spring on width {
                    }

                    MouseArea {
                        id: pillArea

                        property point start

                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onEntered: {
                            pillRect.hovered = true
                        }
                        onExited: {
                            pillRect.hovered = false
                        }
                        onPressed: (m) => start = mapToItem(null, m.x, m.y)
                        onPositionChanged: (m) => {
                            if (!pressed)
                                return
                            const p = mapToItem(null, m.x, m.y)
                            const dx = p.x - start.x
                            const dy = p.y - start.y
                            const d = Math.hypot(dx, dy)
                            if (d === 0)
                                return
                            const k = pillRect.maxRadius * Math.tanh(d / (pillRect.maxRadius * pillRect.resistance)) / d
                            t.x = dx * k
                            t.y = dy * k
                        }
                        onReleased: {
                            t.x = 0
                            t.y = 0
                        }
                        onClicked: function(mouse) {
                            // Let them do other stuff if maximized, i dont like it getting changed randomly
                            if (mouse.button === Qt.RightButton)
                                pillState.cyclePill()

                            if (mouse.button === Qt.LeftButton) {
                                Shellstate.debug() // (debug) i use this for trying out whats inside a variable
                                pillState.toggleMaximized()
                            }
                        }
                        onWheel: (wheel) => {
                            if (!AudioService.sink?.ready || !AudioService.sink.audio)
                                return
                            const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                            AudioService.sink.audio.volume = Math.max(0, Math.min(1, AudioService.sink.audio.volume + step))
                            wheel.accepted = true
                        }
                    }

                    ClockModule {
                        id: clockModule

                        pill: pillState
                    }

                    MediaModule {
                        id: mediaModule

                        pill: pillState
                    }

                    NotificationModule {
                        id: notifModule

                        pill: pillState
                    }

                    VolumeSliderModule {
                        id: volumeModule

                        pill: pillState
                    }

                    LauncherModule {
                        id: launcherModule

                        pill: pillState
                    }
                    WallpaperModule {
                        id: wallpaperModule

                        pill: pillState
                    }


                }

            }

        }

    }

    HyprlandFocusGrab {
        windows: grabWindows
        active: grabWindows.length > 0
        onCleared: Shellstate.closeAllWidgets()
    }

}
