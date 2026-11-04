import QtQuick
import Quickshell
import qs.Components
import qs.Core

Item {
    id: root

    implicitWidth: 230
    implicitHeight: 38

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Row {
        anchors.centerIn: parent
        spacing: 8
        scale: 1.1

        Text {
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "ddd").replace(".", "")
            font: Typography.titleMedium
        }

        Text {
            color: Colors.md3.primary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
            font: Typography.titleMedium
        }

        Text {
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
            font: Typography.titleMedium
        }

    }

}
