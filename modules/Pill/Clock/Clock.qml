import QtQuick
import Quickshell
import qs.Core
import qs.Components

Item {
    id: root
    implicitWidth: 230
    implicitHeight: 38
    opacity: Shellstate.maximized ? 0 : 1
    scale: Shellstate.maximized ? 2 : 1

    Spring on scale{}
    Spring on opacity{}

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Row {
        anchors.centerIn: parent
        spacing: 8
        // evt bald "Google Sans Flex" als font?
        Text {
            font.family: "Rubik"
            color: Theme.text
            text: Qt.locale("de_DE").toString(clock.date, "ddd").replace(".", "")
            // Qt.formatDateTime(clock.date, "ddd") aber bin deutscher
        }
        Text {
            font.family: "Rubik"
            color: Theme.secondary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
        }
        Text {
            font.family: "Rubik"
            color: Theme.text
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
        }
    }
}
