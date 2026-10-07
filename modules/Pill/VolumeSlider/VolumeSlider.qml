import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.Core
import qs.Components
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
        color: Theme.transparency(Theme.text, 0.3)
        Smooth on width{}
        Rectangle {
            anchors.right: parent.right
            width: 30
            height: 30
            radius: 10
            color: Theme.transparency(Qt.lighter(Theme.text, 1.3), 0.3)
        }
    }
}
