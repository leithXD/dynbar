import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.Core
pragma Singleton

Singleton {
    id: root

    property var sink: Pipewire.defaultAudioSink
    property var volume: sink.audio.volume

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

}
