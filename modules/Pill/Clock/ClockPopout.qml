import QtQuick
import Quickshell
import qs.Components
import qs.Core

Item {
    id: root

    required property var pill

    implicitWidth: 350
    implicitHeight: 80
    scale: pill.maximized ? 3 : 1
    opacity: pill.maximized ? 1 : 0

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Row {
        anchors.centerIn: parent
        spacing: 8

        Text {
            // Qt.formatDateTime(clock.date, "ddd") aber bin deutscher

            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "ddd").replace(".", "")
            font: Typography.bodyMedium
        }

        Text {
            color: Colors.md3.primary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
            font: Typography.bodyMedium
        }

        Text {
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
            font: Typography.bodyMedium
        }

    }

    Spring on scale {
    }

    Spring on opacity {
    }

}
