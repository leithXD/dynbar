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
        color: Colors.layer(Colors.md3.on_surface, 1)

        Rectangle {
            anchors.right: parent.right
            width: 30
            height: 30
            radius: 10
            color: Colors.layer(Qt.lighter(Colors.md3.on_surface, 1.3), 1)
        }

        Smooth on width {
        }

    }

}
