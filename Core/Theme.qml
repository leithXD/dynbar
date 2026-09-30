pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property string wallpaper: "/home/leithrice/.local/state/nova/current"
    property int componentRadius: 20
    property int componentRadiusSmall: componentRadius / 2
    property color primary: "red"
    function transparency(hexColor, alpha) {
        const c = Qt.color(hexColor)
        return Qt.rgba(c.r, c.g, c.b, alpha)
    }
}
