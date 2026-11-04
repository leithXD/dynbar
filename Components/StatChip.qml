import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    required property string text
    required property string icon
    property string rectColor: Colors.md3.inverse_on_surface
    property string color: "white"
    property int padding: 20

    implicitWidth: padding + usage.width + materialIcon.width
    implicitHeight: 30

    Rectangle {
        anchors.centerIn: parent
        width: root.implicitWidth
        height: 30
        radius: 15
        color: Colors.layer(root.rectColor, 2)

        Text {
            id: usage

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 5
            font: Typography.titleMedium
            color: Colors.md3.on_surface
            text: root.text
        }

        MaterialIcon {
            id: materialIcon

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
