import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Core

Variants {
  model: Quickshell.screens;

  delegate: Component {
        PanelWindow {
            id: root
            WlrLayershell.namespace: "wallpaper"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            screen: modelData
            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            anchors{
                top: true
                bottom: true
                right: true
                left: true
            }
            Image {
                id: wallpaper
                source: Shellstate.currentWallpaper
                anchors.fill: parent
            }
        }
    }
}
