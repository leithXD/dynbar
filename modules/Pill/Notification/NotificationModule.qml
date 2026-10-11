import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    name: "notification"
    standalone: true

    Timer {
        id: dismiss

        interval: 2000
        onTriggered: {
            if (Shellstate.canGrabAttention) {
                Shellstate.dismissTransient();
            }
        }
    }

    Connections {
        function onReceived() {
            if (Shellstate.canGrabAttention)
                Shellstate.showTransient("notification");

            dismiss.restart();
        }

        target: NotificationService
    }

    expanded: Notification {
    }

}
