import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    name: "volume"
    standalone: true

    Timer {
        id: dismiss

        interval: 1000
        onTriggered: Shellstate.dismissTransient()
    }

    Connections {
        function onVolumeChanged() {
            if (Shellstate.canGrabAttention)
                Shellstate.showTransient("volume");

            dismiss.restart();
        }

        target: AudioService
    }

    expanded: VolumeSlider {
    }

}
