import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Core

PanelWindow {
    anchors.top: true
    WlrLayershell.namespace: "Dashboard"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    WlrLayershell.exclusiveZone: -1
    mask: Region {
        item: pillRect
    }
    color: "transparent"
    implicitHeight: 600
    implicitWidth: 600
    Rectangle {
        id: pillRect
        radius: 20
        width: hovered ? 400 : 230
        height: hovered ? 130 : 30
        scale: pillArea.pressed ?  1.04 : 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        color: "black"
        property bool hovered: false
        Behavior on scale{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        Behavior on height{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        Behavior on width{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        MouseArea {
            id: pillArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                pillRect.hovered = true
            }
            onExited: {
                pillRect.hovered = false
            }
        }
    }
}
