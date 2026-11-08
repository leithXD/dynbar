import M3Shapes
import QtQuick
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    property int value: 200 - SysmonService.cpuUsage * 2

    anchors.fill: parent

    Text {
        id: cpuText

        anchors.centerIn: parent
        text: SysmonService.cpuUsage
        font: Typography.displayLarge
        color: Colors.md3.on_surface
    }

    Rectangle {
        width: parent.width
        height: parent.height - value
        anchors.bottom: parent.bottom
        clip: true
        color: "transparent"

        MaterialShape {
            y: -value
            width: root.width
            height: root.height
            shape: MaterialShape.Cookie6Sided
            color: Colors.md3.primary
        }

        Text {
            x: cpuText.x
            y: cpuText.y - value
            text: SysmonService.cpuUsage
            font: Typography.displayLarge
            color: Colors.md3.on_primary
        }

        Spring on height {
        }

    }

}
