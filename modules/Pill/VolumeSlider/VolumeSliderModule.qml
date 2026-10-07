import QtQuick
import Quickshell
import qs.Components
import qs.Services
import qs.Core

PillModule {
    name: "volume"
    standalone: true
    expanded: VolumeSlider {}

    Timer { id: dismiss; interval: 1000; onTriggered: Shellstate.dismissTransient() }

    Connections {
        target: AudioService
        function onVolumeChanged() {
            if (Shellstate.canGrabAttention) {
                Shellstate.showTransient("volume")
            }
            dismiss.restart()
        }
    }
}
