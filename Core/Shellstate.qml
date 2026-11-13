import QtQuick
import Quickshell
import Quickshell.Hyprland
pragma Singleton

Singleton {
    id: root

    property string home: Quickshell.env("HOME") 
    property string wallpaper: home + "/.local/state/dynbar/wallpaper/current"
    property string wallpaperPath
    property bool wallpaperLoaderEnabled: false
    property bool initialWallpaper: true
    property int currentWallpaperIndex // hardcoded rn ill do it later
    property string avatar: home + "/.face"

    onWallpaperChanged: {
        if (initialWallpaper) {
            initialWallpaper = false
        } else {
            wallpaperLoaderEnabled = true
        }
    }

    property int sidePanelListHeight: 85
    property var printStatement: ""

    signal fileReceived(string file)

    property var pills: []

    function register(p) {
        pills = pills.concat([p])
    }

    function unregister(p) {
        pills = pills.filter(x => x !== p)
    }

    // state for a specific monitor
    function stateFor(screenName) {
        return pills.find(p => p.screenName === screenName) ?? null
    }

    // state for focused monitor
    function focused() {
        return stateFor(Hyprland.focusedMonitor?.name ?? "") ?? pills[0] ?? null
    }

    function closeAllWidgets() {
        pills.forEach(p => p.maximized = false)
    }

    function createToast(name, desc, icon) {
        ToastsModel.append({
            "name": name,
            "description": desc,
            "icon": icon
        })
    }

    function debug() {
        printStatement && console.log(printStatement);
    }
}
