import QtQuick
import Quickshell
import Quickshell.Hyprland
pragma Singleton

Singleton {
    id: root

    property string currentWallpaper: "/home/leith/Pictures/Wallpapers/peak/BotanicGardenJapan.png" // hardcoded rn
    property int sidePanelListHeight: 85
    property var printStatement: ""

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

    function debug() {
        printStatement && console.log(printStatement);
    }
}
