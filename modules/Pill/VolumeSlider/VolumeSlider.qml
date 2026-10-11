import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    implicitWidth: 300
    implicitHeight: 60

    ClippingRectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 15
        height: 30
        width: (root.implicitWidth - 30) * AudioService.volume
        radius: 10
        color: Colors.transparency(Colors.md3.on_surface, 0.3)

        Rectangle {
            anchors.right: parent.right
            width: 30
            height: 30
            radius: 10
            color: Colors.transparency(Qt.lighter(Colors.md3.on_surface, 1.3), 0.3)
        }

        Smooth on width {
        }

    }

}
