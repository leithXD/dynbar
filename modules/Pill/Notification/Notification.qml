import QtQuick
import Quickshell.Widgets
import qs.Core
import qs.Services

Item {
    id: root

    property int maxHeight: 100
    property bool bigMessage: msg.height > maxHeight
    property int maxBodyLines: 6

    implicitWidth: bigMessage ? 500 : 400
    implicitHeight: bigMessage ? maxHeight + 75 : 68 + msg.height

    Rectangle {
        width: root.width - 10
        height: root.height - 12
        radius: 15
        anchors.centerIn: parent
        color: Colors.transparency(Colors.md3.surface_variant, 0.1)

        Column {
            spacing: 8
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 10

            Text {
                id: header

                text: NotificationService.summary
                color: Colors.md3.on_surface // change that
                font.family: "Rubik"
            }

            Text {
                id: msg

                width: bigMessage ? 370 : 270
                text: NotificationService.body
                color: Colors.md3.on_surface
                font.family: "Rubik"
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                maximumLineCount: root.maxBodyLines
                textFormat: Text.PlainText
            }

        }

        ClippingRectangle {
            width: 40
            height: 40
            radius: width / 2
            color: "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.fill: parent
                source: NotificationService.image
            }

        }

    }

}
