import QtQuick
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

            WlrLayershell.namespace: "wallpaper"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            screen: modelData
            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore
            color: "black"

            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }

            Item {
                id: wallpaperItem

                property string currentWallpaper
                property bool pendingAnimation: false

                anchors.fill: parent
                clip: true
                Component.onCompleted: {
                    currentWallpaper = Shellstate.wallpaper;
                }

                Connections {
                    function onWallpaperChanged() {
                        wallpaperItem.pendingAnimation = true;
                    }

                    target: Shellstate
                }

                Image {
                    id: wallpaper

                    anchors.fill: parent
                    source: parent.currentWallpaper
                    sourceSize.width: width
                    sourceSize.height: height
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                }

                ClippingRectangle {
                    id: overlay

                    anchors.centerIn: parent
                    width: 100
                    height: 100
                    radius: 20
                    color: "transparent"
                    opacity: width === 100 ? 0 : 1

                    Image {
                        id: animationWallpaper

                        anchors.centerIn: parent
                        width: root.screen.width
                        height: root.screen.height
                        source: Shellstate.wallpaper
                        sourceSize.width: width
                        sourceSize.height: height
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        onStatusChanged: {
                            if (status === Image.Ready && wallpaperItem.pendingAnimation) {
                                animation.start();
                                wallpaperItem.pendingAnimation = false;
                            }
                        }
                    }

                }

                SequentialAnimation {
                    id: animation

                    ParallelAnimation {
                        NumberAnimation {
                            target: overlay
                            properties: "width"
                            to: root.screen.width
                            duration: 400
                            easing.type: Easing.OutCubic
                        }

                        NumberAnimation {
                            target: overlay
                            properties: "height"
                            to: root.screen.height
                            duration: 400
                            easing.type: Easing.OutCubic
                        }

                    }

                    ScriptAction {
                        script: {
                            wallpaperItem.currentWallpaper = Shellstate.wallpaper;
                        }
                    }

                    NumberAnimation {
                        target: overlay
                        properties: "opacity"
                        to: 0
                        duration: 0
                    }

                    ParallelAnimation {
                        NumberAnimation {
                            target: overlay
                            properties: "width"
                            to: 100
                            duration: 0
                        }

                        NumberAnimation {
                            target: overlay
                            properties: "height"
                            to: 100
                            duration: 0
                        }

                    }

                }

            }

        }

    }

}
