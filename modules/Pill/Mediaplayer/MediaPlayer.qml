import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    // i think ill just let the miniplayer be enabled for smoother transition and then leave some components here like player stuff, author names and yea

    id: root

    implicitWidth: 700
    implicitHeight: 190

    Equalizer {
        y: 105
        width: root.width
        height: root.height
        barCount: 70
        opacity: 0.2

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing: Easing.OutBack
            }

        }

    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: MediaplayerService.activePlayer === null ? 280 : 210
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 320
        font.weight: Font.DemiBold
        text: MediaplayerService.activePlayer === null ? "Nothing is playing" : Format.cleanTitle(MediaplayerService.trackTitle, MediaplayerService.trackArtist)
        color: Colors.md3.on_surface
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 1
        font.pointSize: 12
        scale: 1.3
    }

    ClippingRectangle {
        id: cover

        width: 128
        height: 128
        radius: width / 2
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Image {
            id: coverImage

            width: cover.width
            height: cover.height
            source: MediaplayerService.trackArtUrl
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true
            mipmap: true
            sourceSize: Qt.size(192, 192)
            antialiasing: true
            visible: status === Image.Ready
        }

        MaterialIcon {
            anchors.centerIn: parent
            name: "error"
            size: 94
            color: Colors.md3.surface_variant
            visible: MediaplayerService.activePlayer === null
        }

        MaterialLoading {
            loading: coverImage.status !== Image.Ready
            width: coverImage.width - 5
            height: coverImage.height - 5
            spacing: 40
            visible: coverImage.status !== Image.Ready && !(MediaplayerService.activePlayer === null)
        }

    }

    Item {
        height: 20
        width: 300
        anchors.left: parent.left
        anchors.leftMargin: 170
        anchors.top: parent.top
        anchors.topMargin: 130

        WavyProgress {
            anchors.centerIn: parent
            scale: 3
            progress: seekArea.pressed ? seekArea.dragProgress : MediaplayerService.progress
            animated: MediaplayerService.isPlaying
            smoothProgress: !seekArea.pressed
        }

        MouseArea {
            id: seekArea

            property real dragProgress: 0

            function update(x) {
                dragProgress = Math.max(0, Math.min(1, x / width));
            }

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onPressed: (mouse) => {
                return update(mouse.x);
            }
            onPositionChanged: (mouse) => {
                return update(mouse.x);
            }
            onReleased: MediaplayerService.seekTo(dragProgress)
            onClicked: {
                console.log(MediaplayerService.desktopEntry);
            }
        }

    }

    Row {
        anchors.top: parent.top
        anchors.topMargin: 110
        anchors.right: parent.right
        anchors.rightMargin: 5
        width: 150
        height: 60
        spacing: 5

        Rectangle {
            id: left

            property bool hovered: false

            anchors.verticalCenter: parent.verticalCenter
            width: leftButton.pressed ? 70 : rightButton.pressed ? 30 : 50
            height: 50
            radius: width / 3
            color: hovered ? Qt.lighter(Colors.md3.primary, 1.3) : Colors.md3.primary

            MaterialIcon {
                id: playButton

                anchors.centerIn: parent
                name: MediaplayerService.isPlaying ? "pause" : "play_arrow"
                color: Colors.md3.on_primary
                fill: 1
                size: 42
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
                    Shellstate.componentHover = true;
                    left.hovered = true;
                }
                onExited: {
                    Shellstate.componentHover = false;
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
            width: rightButton.pressed ? 70 : leftButton.pressed ? 30 : 50
            height: 50
            radius: width / 3
            color: hovered ? Qt.lighter(Colors.md3.secondary, 1.3) : Colors.md3.secondary

            MaterialIcon {
                anchors.centerIn: parent
                name: "skip_next"
                color: Colors.md3.on_secondary
                fill: 1
                size: 42
            }

            MouseArea {
                id: rightButton

                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    MediaplayerService.next();
                }
                onEntered: {
                    Shellstate.componentHover = true;
                    right.hovered = true;
                }
                onExited: {
                    Shellstate.componentHover = false;
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

}
