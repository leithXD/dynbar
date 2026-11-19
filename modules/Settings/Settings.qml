import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core

FloatingWindow {
    id: win

    title: "Dynbar Settings"
    implicitWidth: 1200
    implicitHeight: 700
    visible: true
    onClosed: Shellstate.settingsOpened = false
    color: Colors.md3.surface

    ClippingRectangle {
        height: parent.height - parent.height / 30
        width: 650
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.height / 30 / 2
        radius: 20
        color: Colors.layer(Colors.md3.inverse_on_surface, 2)

        Rectangle {
            height: 50
            width: parent.width - 30
            radius: 20
            color: Colors.md3.surface
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            ToggleRow {
                anchors.centerIn: parent
                title: "Bar floating"
                desc: "Should the bar be floating?"
                targetObject: Config.bar
                targetProperty: "floating"
            }

        }

        Rectangle {
            height: 50
            width: parent.width - 30
            radius: 20
            color: Colors.md3.surface
            anchors.top: parent.top
            anchors.topMargin: 65
            anchors.horizontalCenter: parent.horizontalCenter

            ToggleRow {
                anchors.centerIn: parent
                title: "Pill floating"
                desc: "Should the Pill be floating?"
                targetObject: Config.pill
                targetProperty: "floating"
            }

        }

    }

}
