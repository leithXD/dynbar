import QtQuick
import Quickshell
import Quickshell.Services.Notifications
pragma Singleton

Singleton {
    id: root

    property string appName
    property string summary
    property string body
    property string image
    property string appIcon
    readonly property alias trackedNotifications: notif.trackedNotifications

    signal received()

    NotificationServer {
        id: notif

        bodySupported: true
        keepOnReload: false
        onNotification: (n) => {
            n.tracked = true;
            root.appName = n.appName;
            root.summary = n.summary;
            root.body = n.body;
            root.image = n.image;
            root.appIcon = n.appIcon;
            root.received();
        }
    }

}
