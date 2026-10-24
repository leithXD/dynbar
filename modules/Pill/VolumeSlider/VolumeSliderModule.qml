import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

PillModule {
    id: module

    name: "volume"
    standalone: true

    Timer {
        id: dismiss

        interval: 1000
        onTriggered: module.pill.dismissTransient()
    }

    Connections {
        function onVolumeChanged() {
            if (Shellstate.focused() !== module.pill)
                return ;

            if (module.pill.canGrabAttention)
                module.pill.showTransient("volume");

            dismiss.restart();
        }

        target: AudioService
    }

    expanded: VolumeSlider {
    }

}
