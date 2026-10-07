pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire
import qs.Core
import QtQuick

Singleton {
    id: root
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    property var sink: Pipewire.defaultAudioSink
    property var volume: sink.audio.volume
}
