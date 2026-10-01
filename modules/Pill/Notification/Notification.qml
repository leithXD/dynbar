import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.Core
import Quickshell.Services.Notifications

Item {
    id: root
    width: 400
    height: 80
    anchors.centerIn: parent

    property string notifApp
    property string notifSummary
    property string notifBody
    property string notifImage
    property string notifAppIcon
    Rectangle {
        width: 390 // -10
        height: root.height - 12 // -2
        radius: 15
        anchors.centerIn: parent
        color: Theme.transparency(Theme.surfaceVariant, 0.3)
        Column {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            Text{
                id: header
                text: root.notifSummary
                color: Theme.textDark
                font.family: "Rubik"
            }
            Text{
                id: msg
                width: 270
                text: root.notifBody
                color: Theme.text
                font.family: "Rubik"
                wrapMode: Text.Wrap
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
                anchors.centerIn: parent
                width: 40
                height: 40
                source: root.notifImage
            }
        }
    }

    NotificationServer {
        bodySupported: true
        keepOnReload: false

        onNotification: function(n) {
            root.notifApp     = n.appName;
            root.notifSummary = n.summary; // no use rn lol
            root.notifBody    = n.body;
            root.notifImage   = n.image;
            root.notifAppIcon = n.appIcon;
            root.height = 68 + msg.height
            root.newNotification()
        }
    }

    function newNotification() {
        Shellstate.toggleMode("notification")
        dismissNotif.running = true
    }

    Timer{
        id: dismissNotif
        interval: 2000
        repeat: false
        onTriggered: Shellstate.toggleMode("none")
    }
}
