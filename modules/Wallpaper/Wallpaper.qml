import QtQuick
import Quickshell
import Quickshell.Wayland
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
                anchors.fill: parent
                clip: true

                Image {
                    id: wallpaperOld

                    anchors.fill: parent
                    source: Shellstate.wallpaperOld
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    cache: true
                }

                Image {
                    id: wallpaper

                    anchors.fill: parent
                    source: Shellstate.wallpaper
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    cache: true
                    opacity: status === Image.Ready ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 250
                        }

                    }

                }

            }

        }

    }

}
