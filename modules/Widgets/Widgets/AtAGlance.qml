import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Core

Item {
    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: Qt.locale("de_DE").toString(clock.date, "ddd").replace(".", "")
            font: Typography.bodyLarge
            color: Colors.md3.on_surface
        }

    }

}
