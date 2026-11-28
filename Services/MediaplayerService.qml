pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import qs.Core

Singleton {
    id: root
    // Music player
    readonly property MprisPlayer activePlayer:
            Mpris.players.values.find(p => p.isPlaying)
            ?? Mpris.players.values[0]
            ?? null

    readonly property bool hasPlayer: activePlayer !== null
    readonly property string trackArtist: activePlayer?.trackArtist ?? ""
    readonly property string trackArtUrl: activePlayer?.trackArtUrl ?? ""
    readonly property string trackTitle: activePlayer?.trackTitle ?? ""
    readonly property string artist: activePlayer?.trackArtist ?? ""
    readonly property bool isPlaying: activePlayer?.isPlaying ?? false
    readonly property real position: activePlayer?.position ?? 0
    readonly property real length: activePlayer?.length ?? 0
    readonly property real progress: length > 0 ? position / length : 0
    readonly property string desktopEntry: activePlayer?.desktopEntry ?? ""

    // lyrics
    property var timestamps: []
    property var lines: []

    readonly property int currentIndex: {
        let idx = -1;
        for (let i = 0; i < timestamps.length; i++) {
            if (position * 1000 >= timestamps[i]) {
                idx = i;
            } else {
                break;
            }
        }
        return idx;
    }

    onTrackTitleChanged: {
        debounce.restart()
    }

    Timer{
        id: debounce // trackartist and tracktitle race condition fix T_T
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            Shellstate.createToast("Now Playing", trackTitle + " by " + trackArtist, "music_note")
            getLyrics.running = false
            getLyrics.running = true
        }
    }

    function seekTo(fraction) { if (activePlayer?.canSeek && length > 0) activePlayer.position = Math.max(0, Math.min(1, fraction)) * length; }
    function togglePlaying() { if (activePlayer?.canTogglePlaying) activePlayer.togglePlaying(); }
    function next()          { if (activePlayer?.canGoNext) activePlayer.next(); }
    function previous()      { if (activePlayer?.canGoPrevious) activePlayer.previous(); }

    function parseLrcToArrays(lrcText, totalDurationSec) {
        // thanks claude
        const newTimestamps = [];
        const newLines = [];

        if (!lrcText) {
            timestamps = [];
            lines = [];
            return;
        }

        const rawLines = lrcText.split(/\r?\n/);
        const timeRegex = /^\[(\d{2}):(\d{2})\.(\d{2,3})\]\s*(.*)$/;

        for (let i = 0; i < rawLines.length; i++) {
            const match = rawLines[i].trim().match(timeRegex);
            if (!match) continue;

            const minutes = parseInt(match[1], 10);
            const seconds = parseInt(match[2], 10);
            const fracStr = match[3].padEnd(3, "0");
            const millis = parseInt(fracStr, 10);

            const ms = minutes * 60000 + seconds * 1000 + millis;
            const text = match[4];

            newTimestamps.push(ms);
            newLines.push(text);
        }

        timestamps = newTimestamps;
        lines = newLines;
    }

    Process {
        id: getLyrics
        running: false
        command: ["dynbar", "lyrics", trackTitle, trackArtist]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(this.text);
                    root.parseLrcToArrays(data.syncedLyrics, data.duration);
                } catch (e) {
                    console.warn("Lyrics JSON parse error:", e);
                }
            }
        }
        
    }

    Timer {
        interval: 400
        repeat: true
        running: activePlayer.playbackState == MprisPlaybackState.Playing
        onTriggered: {
            root.activePlayer.positionChanged()
            // console.log("Progress: " + root.progress + " Length: " + root.length + " Position: " + root.position) the fucking position just keeps incrementing
        }
    }
}
