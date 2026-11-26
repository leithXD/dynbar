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
import "Settings"

Scope {
    readonly property var grabWindows: pills.instances.filter(w => w.wantsGrab)

    Variants {
        id: pills

        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: root

                required property var modelData
                readonly property bool needsFocus: pillState.activePill === "launcher" || pillState.activePill === "wallpaper"
                readonly property bool wantsGrab: pillState.wantsGrab

                screen: modelData
                anchors.top: true
                WlrLayershell.namespace: "dynbar"
                WlrLayershell.keyboardFocus: needsFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
                WlrLayershell.exclusiveZone: -1
                color: "transparent"
                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                mask: Region {
                    item: pillRect
                }

                PillState {
                    id: pillState

                    screenName: root.modelData.name
                }

                ClippingRectangle {
                    id: pillRect

                    readonly property var modules: [clockModule, mediaModule, notifModule, volumeModule, launcherModule, wallpaperModule, settingsModule]
                    readonly property var current: modules.find(m => m.name === pillState.activePill)
                    property bool hovered: false
                    property bool activated: false
                    property real maxRadius: 4
                    property real resistance: 5

                    width: current && current.targetWidth > 0 ? current.targetWidth : 230
                    height: current && current.targetHeight > 0 ? current.targetHeight : 38
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: pillState.isFullscreen ? -50 : (pillState.activePill === "launcher" && Config.pill.floating ? (root.height / 2) - 100 - pillState.launcherCount * 30 : 6 - displacement)
                    property int displacement: Config.pill.floating ? 0 : 6
                    scale: pillArea.pressed ? 1.05 : 
       (pillRect.hovered || pillState.componentHover) ? 1.02 : 1.0
                    color: Colors.surface(Colors.md3.surface)
                    clip: true
                    radius: pillState.activePill === "settings" ? 30 : 20

                    Anim on radius {}

                    states: [
                        State {
                            name: "docked"
                            when: !Config.pill.floating
                            PropertyChanges {
                                target: pillRect
                                topLeftRadius: 0
                                topRightRadius: 0
                            }
                        }   
                    ]

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

                    Anim on anchors.topMargin {
                    }

                    Anim on scale {
                        state: ""
                        duration: 200
                        curve: Animations.anim.spring
                    }

                    Anim on height {
                    }

                    Anim on width {
                    }

                    Anim on topLeftRadius {
                        state: "emphasized"
                    }
                    Anim on topRightRadius {
                        state: "emphasized"
                    }

                    MouseArea {
                        id: pillArea

                        property point start

                        anchors.fill: parent
                        hoverEnabled: pillState.allPills.includes(pillState.activePill)
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
                            if (!pillState.maximized){
                                const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                                AudioService.sink.audio.volume = Math.max(0, Math.min(1, AudioService.sink.audio.volume + step))
                                wheel.accepted = true

                            }
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
                        onNotification: {
                            notifPopup.start()

                        }
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
                    SettingsModule {
                        id: settingsModule

                        pill: pillState
                    }


                    SequentialAnimation {
                        id: notifPopup
                        NumberAnimation {
                            target: pillRect
                            properties: "scale"
                            to: 1.02
                            easing.type: Easing.OutBack
                            duration: 200
                        }

                        NumberAnimation {
                            target: pillRect
                            properties: "scale"
                            to: 1
                            easing.type: Easing.OutBack
                            duration: 200
                        }

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
