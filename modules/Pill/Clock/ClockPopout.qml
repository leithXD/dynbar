import QtQuick
import Quickshell
import qs.Core
import qs.Components

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

    Spring on scale {}
    Spring on opacity {}

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
            color: Theme.primary
            text: Qt.locale("de_DE").toString(clock.date, "dd")
        }
        Text {
            font.family: "Rubik"
            color: Theme.text
            text: Qt.locale("de_DE").toString(clock.date, "hh:mm")
        }
    }
}
