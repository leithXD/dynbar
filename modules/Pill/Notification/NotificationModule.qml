import QtQuick
import Quickshell
import qs.Components
import qs.Services
import qs.Core

PillModule {
    name: "notification"
    standalone: true
    expanded: Notification {}

    Timer { id: dismiss; interval: 2000; onTriggered: Shellstate.dismissTransient() }

    Connections {
        target: NotificationService
        function onReceived() {
            if (Shellstate.canGrabAttention) {
                Shellstate.showTransient("notification")
            }
            dismiss.restart()
        }
    }
}
