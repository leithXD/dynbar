import QtQuick
import Quickshell
import qs.Core

Item {
    id: root

    property bool active: false

    width: 70
    height: 35

    Rectangle {
        id: outerRect

        anchors.fill: parent
        color: root.active ? Colors.md3.primary : Colors.md3.inverse_on_surface
        radius: height / 2

        Rectangle {
            // EDecel on x {
            // }

            width: 25
            height: 25
            radius: width / 2
            color: Colors.md3.surface_variant
            anchors.verticalCenter: parent.verticalCenter
            x: root.active ? outerRect.width - 5 - width : 5
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
            }

        }

    }

    MouseArea {
        id: click

        anchors.fill: parent
        onClicked: root.active = !root.active
    }

}
