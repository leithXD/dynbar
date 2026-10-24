import QtQuick
import Quickshell
import qs.Core
import qs.Services

Row {
    width: 50
    height: 30
    spacing: 5

    Rectangle {
        id: left

        property bool hovered: false

        anchors.verticalCenter: parent.verticalCenter
        width: leftButton.pressed ? 35 : rightButton.pressed ? 15 : 25
        height: 25
        radius: width / 3
        color: hovered ? Qt.lighter(Colors.md3.primary, 1.3) : Colors.md3.primary

        MaterialIcon {
            id: playButton

            anchors.centerIn: parent
            name: MediaplayerService.isPlaying ? "pause" : "play_arrow"
            color: Colors.md3.on_primary
            fill: 1
            size: 21
        }

        MouseArea {
            id: leftButton

            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                if (playButton.name === "pause")
                    playButton.name = "play_arrow";
                else
                    playButton.name = "pause"; // ill fix that later no one will spam click, this is just buggy on bad (slow) media players lowkey
                MediaplayerService.togglePlaying();
            }
            onEntered: {
                left.hovered = true;
            }
            onExited: {
                left.hovered = false;
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }

        }

        Spring on width {
        }

    }

    Rectangle {
        id: right

        property bool hovered: false

        anchors.verticalCenter: parent.verticalCenter
        width: rightButton.pressed ? 35 : leftButton.pressed ? 15 : 25
        height: 25
        radius: width / 3
        color: hovered ? Qt.lighter(Colors.md3.secondary, 1.3) : Colors.md3.secondary

        MaterialIcon {
            anchors.centerIn: parent
            name: "skip_next"
            color: Colors.md3.on_secondary
            fill: 1
            size: 21
        }

        MouseArea {
            id: rightButton

            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                MediaplayerService.next();
            }
            onEntered: {
                right.hovered = true;
            }
            onExited: {
                right.hovered = false;
            }
        }

        Spring on width {
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }

        }

    }

}
