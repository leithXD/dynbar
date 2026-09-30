pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property string wallpaper: "/home/leithrice/.local/state/nova/current"
    property int componentRadius: 20
    property int componentRadiusSmall: componentRadius / 2

    property color primary: "#747b49"
    property color primaryAlt: "#3d4318"
    property color subComponents: "#191a11"

    property color text: "#e7e6d4"
    property color textDark: "#ffecc9"

    property color secondary: "#c6c9a7"
    property color secondaryAlt: "#3f4229"
    property color tertiary: "#ffecc9"
    property color tertiaryAlt: "#6c551f"

    property color successAlt: "#213528"
    property color inverseOnSurface: "#56554e"

    property color surface: "#0e0f09"
    property color surfaceVariant: "#25271b"
    property color surfaceContainerLow: "#13140c"
    property color surfaceContainer: "#191a11"
    property color surfaceContainerHigh: "#1f2016"

    property color outline: "#767667"
    property color error: "#f97758"


    function transparency(hexColor, alpha) {
        const c = Qt.color(hexColor)
        return Qt.rgba(c.r, c.g, c.b, alpha)
    }
}
