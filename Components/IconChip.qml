import QtQuick
import Quickshell
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    required property string icon
    property string color: "white"
    property int padding: 20

    signal clicked()

    implicitWidth: padding + materialIcon.width
    implicitHeight: 30

    Rectangle {
        anchors.centerIn: parent
        width: root.implicitWidth
        height: 30
        radius: 15
        color: Colors.layer(Colors.md3.inverse_on_surface, 2)

        MaterialIcon {
            id: materialIcon

            anchors.centerIn: parent
            name: root.icon
            color: root.color
            size: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }

        // i should prob change this so it doesnt change width so often, maybe static is better for cpu and ram
        Spring on width {
        }

    }

}
