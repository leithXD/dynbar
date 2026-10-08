import QtQuick
import Quickshell
import qs.Components
import qs.Services
import qs.Core

PillModule {
    name: "chargingstate"
    standalone: true
    expanded: BatteryTransient {}

    Timer { id: dismiss; interval: 1000; onTriggered: Shellstate.dismissTransient() }

    Connections {
        target: BatteryService
        function onUsesBatteryChanged() {
            if (Shellstate.canGrabAttention) {
                Shellstate.showTransient("chargingstate")
            }
            dismiss.restart()
        }
    }
}
