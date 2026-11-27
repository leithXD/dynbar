import QtQuick
import Quickshell.Io
import qs.Core

Item {
    id: root

    property int barCount: 50
    property int barSpacing: 3
    property int framerate: 30
    property color barColor: Colors.md3.primary
    property bool active: root.visible
}
