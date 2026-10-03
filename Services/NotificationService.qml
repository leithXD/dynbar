pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root
    property string appName
    property string summary
    property string body
    property string image
    property string appIcon
    signal received()

    NotificationServer {
        bodySupported: true
        keepOnReload: false
        onNotification: n => {
            root.appName = n.appName
            root.summary = n.summary
            root.body    = n.body
            root.image   = n.image
            root.appIcon = n.appIcon
            root.received()
        }
    }
}
