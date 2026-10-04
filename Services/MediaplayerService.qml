pragma Singleton
import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
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

    function seekTo(fraction) { if (activePlayer?.canSeek && length > 0) activePlayer.position = Math.max(0, Math.min(1, fraction)) * length; }
    function togglePlaying() { if (activePlayer?.canTogglePlaying) activePlayer.togglePlaying(); }
    function next()          { if (activePlayer?.canGoNext) activePlayer.next(); }
    function previous()      { if (activePlayer?.canGoPrevious) activePlayer.previous(); }
}
