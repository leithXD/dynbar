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

    implicitWidth: padding + textMetric.width + materialIcon.width
    implicitHeight: 30

    Rectangle {
        anchors.centerIn: parent
        width: root.implicitWidth
        height: 30
        radius: 15
        color: Colors.layer(root.rectColor, 2)

        Item {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 3
            anchors.leftMargin: 5
            width: textMetric.width + 10
            height: textMetric.height + 5

            Text {
                id: usage

                anchors.centerIn: parent
                font: Typography.titleMedium
                color: Colors.md3.on_surface
                text: root.text
            }

        }

        TextMetrics {
            id: textMetric

            text: "100"
            font: Typography.titleMedium
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
