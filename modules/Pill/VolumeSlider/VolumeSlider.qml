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

    Item {
        id: trackContainer

        readonly property real maxDragX: Math.max(0, width - dragBox.width)

        anchors.margins: 10
        anchors.fill: parent

        ClippingRectangle {
            width: Math.max(dragBox.width, dragBox.x + dragBox.width)
            anchors.left: parent.left
            height: parent.height
            color: Colors.layer(Colors.md3.primary, 1)
            radius: 20 - 10

            Rectangle {
                id: dragBox

                anchors.verticalCenter: parent.verticalCenter
                width: parent.height
                height: parent.height
                radius: 10
                x: !dragHandler.active ? trackContainer.maxDragX * Math.max(0, Math.min(1, AudioService.volume)) : x
                onXChanged: {
                    if (dragHandler.active && trackContainer.maxDragX > 0) {
                        const normalized = Math.max(0, Math.min(1, x / trackContainer.maxDragX));
                        AudioService.sink.audio.volume = normalized;
                    }
                }
                color: Colors.layer(Qt.lighter(Colors.md3.primary, 1.3), 1)

                Anim on x {
                    enabled: !dragHandler.active
                    state: "standard"
                }

            }

            DragHandler {
                id: dragHandler

                target: dragBox
                xAxis.minimum: 0
                xAxis.maximum: trackContainer.maxDragX
                yAxis.enabled: false
            }

        }

    }

}
