import "Backend"
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core

Item {
    implicitWidth: 500
    implicitHeight: 600

    CliphistBackend {
        id: cliphist
    }

    ListView {
        anchors.margins: 20
        anchors.fill: parent
        spacing: 2
        model: cliphist.model

        delegate: Rectangle {
            width: parent.width
            height: 60
            radius: 20
            color: Colors.layer(Colors.md3.inverse_on_surface, 2)
        }

    }

}
