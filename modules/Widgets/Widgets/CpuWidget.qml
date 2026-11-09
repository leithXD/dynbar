import M3Shapes
import QtQuick
import qs.Components
import qs.Core
import qs.Services

Item {
    anchors.fill: parent

    Rectangle {
        width: parent.width
        height: SysmonService.cpuUsage * 2
        anchors.bottom: parent.bottom
        color: Colors.md3.primary

        Smooth on height {
        }

    }

}
