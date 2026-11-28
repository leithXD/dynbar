import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import qs.Core
import qs.Services

Item {
    id: root

    property real value: MediaplayerService.length > 0 ? Math.max(0, Math.min(1, MediaplayerService.position / MediaplayerService.length)) : 0
    property bool playing: MediaplayerService.isPlaying
    property int spacing: 5
    property bool dragging
    property real progress: MediaplayerService.progress * root.width
    property real dragProgress

    function boundaries(x) {
        return Math.max(0, Math.min(x, root.width));
    }

    Rectangle {
        id: leftTrack

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        height: root.height / 2
        width: handle.x - spacing
        color: Colors.md3.primary
        radius: 10
    }

    Rectangle {
        id: handle

        anchors.verticalCenter: parent.verticalCenter
        height: 30
        width: 5
        color: Colors.md3.primary
        radius: 8
        x: dragging ? root.dragProgress : root.boundaries(root.progress)
    }

    Rectangle {
        id: rightTrack

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        height: root.height / 2
        width: root.width - handle.x - handle.width - spacing
        color: Colors.layer(Colors.md3.inverse_on_surface)
        radius: 10
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            MediaplayerService.seekTo(mouse.x / root.width);
        }
        preventStealing: true
        onPressed: (mouse) => {
            root.dragging = true;
            root.dragProgress = Math.max(0, Math.min(root.width, mouse.x - handle.width / 2));
        }
        onPositionChanged: (mouse) => {
            if (!root.dragging)
                return ;

            root.dragProgress = Math.max(0, Math.min(root.width, mouse.x - handle.width / 2));
        }
        onReleased: (mouse) => {
            if (!root.dragging)
                return ;

            MediaplayerService.seekTo(mouse.x / root.width);
            root.dragging = false;
        }
        onCanceled: {
            root.dragging = false;
        }
    }

}
