import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    id: root

    anchors.fill: parent
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    RowLayout {
        id: row

        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: 5

            Workspace {
            }

        }

    }

}
