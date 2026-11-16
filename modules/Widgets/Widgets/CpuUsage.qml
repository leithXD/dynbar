import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

Item {
    anchors.fill: parent

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: SysmonService.cpuUsage * 2
        color: Colors.md3.primary

        Smooth on height {
        }

    }

}
