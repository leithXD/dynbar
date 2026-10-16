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

        // evt bald "Google Sans Flex" als font?
        Text {
            // Qt.formatDateTime(clock.date, "ddd") aber bin deutscher

            font.family: "Rubik"
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "ddd").replace(".", "")
            font.pointSize: 14
        }

        Text {
            font.family: "Rubik"
            color: Colors.md3.primary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
            font.pointSize: 14
        }

        Text {
            font.family: "Rubik"
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
            font.pointSize: 14
        }

    }

}
