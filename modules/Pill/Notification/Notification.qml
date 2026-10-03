import QtQuick
import Quickshell.Widgets
import qs.Core
import qs.Services

Item {
    id: root
    implicitWidth: bigMessage ? 500 : 400
    implicitHeight: bigMessage ? maxHeight + 75 : 68 + msg.height

    property int maxHeight: 100
    property bool bigMessage: msg.height > maxHeight
    property int maxBodyLines: 6

    Rectangle {
        width: root.width - 10
        height: root.height - 12
        radius: 15
        anchors.centerIn: parent
        color: Theme.transparency(Theme.surfaceVariant, 0.3)

        Column {
            spacing: 8
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 10
            Text {
                id: header
                text: NotificationService.summary
                color: Theme.textDark
                font.family: "Rubik"
            }
            Text {
                id: msg
                width: bigMessage ? 370 : 270
                text: NotificationService.body
                color: Theme.text
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
