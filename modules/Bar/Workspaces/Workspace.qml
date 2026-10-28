import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Core
import qs.Components

Rectangle {
    id: rect
    property var ws: Hyprland.workspaces.values.find(w => w.id === wsIdReal)
    property int currentBlockOffset: Math.floor((currentId - 1) / 5) * 5
    property int wsIdReal: currentBlockOffset + wsId
    property int currentId: Hyprland.focusedWorkspace?.id ?? 0
    property int focusedWindow: ((currentId  - 1) % 5) + 1
    property int wsId: index + 1
    property bool isActive: focusedWindow === wsId

    property int activate

    Layout.preferredWidth: isActive ? 50 : 27
    Layout.preferredHeight: 27
    radius: Layout.preferredHeight / 2
    color: isActive ? Colors.md3.primary : ( rect.ws ? Qt.lighter(Colors.md3.primary_container, 0.7) : Colors.md3.outline_variant)
    scale: area.pressed ? 0.9 : (area.containsMouse ? 1.1 : 1.0) 

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on scale {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            rect.ws.activate()
        }
    }
}

