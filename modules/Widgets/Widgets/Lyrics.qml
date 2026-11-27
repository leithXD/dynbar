import QtQuick
import qs.Core
import qs.Services

ListView {
    id: root

    anchors.fill: parent
    anchors.margins: 20
    model: MediaplayerService.lines
    spacing: 10
    highlightMoveDuration: 300
    currentIndex: MediaplayerService.currentIndex
    preferredHighlightBegin: (height / 2) - 40
    preferredHighlightEnd: (height / 2) + 40
    highlightRangeMode: ListView.StrictlyEnforceRange

    delegate: Rectangle {
        id: rect

        required property var modelData
        property bool isCurrentItem: ListView.isCurrentItem

        width: root.width
        height: 80
        color: isCurrentItem ? Colors.md3.primary : "transparent"
        radius: 20

        Text {
            scale: rect.isCurrentItem ? 1 : 0.7
            anchors.centerIn: parent
            text: rect.modelData
            color: rect.isCurrentItem ? Colors.md3.on_primary : Colors.md3.on_surface
            font: Typography.titleLarge
            width: parent.width - 20
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter

            Behavior on color {
                ColorAnimation {
                    duration: 300
                }

            }

            Anim on scale {
            }

        }

        Behavior on color {
            ColorAnimation {
                duration: 300
            }

        }

    }

}
