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
        color: Colors.transparency(root.rectColor, 0.5)

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
