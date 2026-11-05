import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    id: module

    signal notification()

    name: "notification"
    standalone: true

    Timer {
        id: dismiss

        interval: 2000
        onTriggered: {
            if (module.pill.canGrabAttention)
                module.pill.dismissTransient();

        }
    }

    Connections {
        function onReceived() {
            if (Shellstate.focused() !== module.pill)
                return ;

            if (module.pill.canGrabAttention) {
                module.notification();
                module.pill.showTransient("notification");
            }
            dismiss.restart();
        }

        target: NotificationService
    }

    expanded: Notification {
    }

}
