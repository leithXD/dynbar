import QtQuick
import Quickshell.Io
import qs.Core

Item {
    id: root

    required property JsonObject targetObject
    required property string targetProperty
    property string type

    width: 150
    height: 50

    Rectangle {
        anchors.fill: parent
        color: Colors.md3.inverse_on_surface
        radius: 20 - 10

        Text {
            anchors.centerIn: parent
            text: root.targetObject[root.targetProperty]
            font: Typography.titleLarge
            color: Colors.md3.on_surface
        }

    }

}
