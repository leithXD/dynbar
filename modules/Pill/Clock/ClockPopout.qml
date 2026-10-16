import QtQuick
import Quickshell
import qs.Components
import qs.Core

Item {
    id: root

    implicitWidth: 350
    implicitHeight: 80
    scale: Shellstate.maximized ? 3 : 1
    opacity: Shellstate.maximized ? 1 : 0

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
            font.pointSize: 12
        }

        Text {
            font.family: "Rubik"
            color: Colors.md3.primary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
            font.pointSize: 12
        }

        Text {
            font.family: "Rubik"
            color: Colors.md3.on_surface
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
            font.pointSize: 12
        }

    }

    Spring on scale {
    }

    Spring on opacity {
    }

}
