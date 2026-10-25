import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    required property string text
    required property string icon
    property string color: "white"
    property int padding: 40

    implicitWidth: padding + usage.width
    implicitHeight: 30

    Rectangle {
        anchors.centerIn: parent
        width: root.implicitWidth
        height: 30
        radius: 15
        color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)

        Text {
            id: usage

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            font.pointSize: 14
            color: Colors.md3.on_surface
            text: root.text
        }

        MaterialIcon {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 4
            name: root.icon
            color: root.color
        }

        Spring on width {
        }

    }

}
