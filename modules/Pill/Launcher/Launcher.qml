import Quickshell
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.Core

Item {
    id: root
    implicitWidth: 600
    implicitHeight: 650
    ClippingRectangle {
        width: 580
        height: 630
        radius: 10
        anchors.centerIn: parent
        color: Theme.transparency(Theme.surfaceVariant, 0.3)
        ScriptModel {
            id: results
            values: {
                const q = search.text.toLowerCase();
                return DesktopEntries.applications.values
                    .filter(e => !e.noDisplay && (
                        e.name.toLowerCase().includes(q) ||
                        e.genericName.toLowerCase().includes(q) ||
                        e.keywords.some(k => k.toLowerCase().includes(q))))
                    .sort((a, b) => a.name.localeCompare(b.name));
            }
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            TextField {
                id: search
                width: 470
                height: 40
                Component.onCompleted: search.forceActiveFocus()
                background: Rectangle {
                    anchors.centerIn: parent
                    radius: 15
                    color: Theme.surface
                    width: search.width + 80
                }
            }
        }
    }
}
