import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Core
import qs.Components
import qs.Services

Item {
    id: root
    implicitWidth: 700
    implicitHeight: 190
    // i think ill just let the miniplayer be enabled for smoother transition and then leave some components here like player stuff, author names and yea

    Equalizer {
        y: 105
        Behavior on scale{
            NumberAnimation{
                duration: 200
                easing: Easing.OutBack
            }
        }
        width: root.width
        height: root.height
        barCount: 70
        opacity: 0.2
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 210
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 320
        font.weight: Font.DemiBold
        text: Format.cleanTitle(MediaplayerService.trackTitle, MediaplayerService.trackArtist)
        color: Theme.text
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 1
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
        MaterialLoading {
            loading: coverImage.status !== Image.Ready
            width: coverImage.width - 5
            height: coverImage.height - 5
            spacing: 40
        }
    }

    Rectangle {
        anchors.fill: cover
        color: "transparent"
        Rectangle {
            width: 30
            height: 30
            radius: width / 2
            color: Theme.transparency(Theme.secondaryAlt, 0.9)
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            property var entry: DesktopEntries.byId(MediaplayerService.desktopEntry)
            Image {
                scale: 0.6
                anchors.fill: parent
                source: Quickshell.iconPath(parent.entry?.icon, true)
            }
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
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            property real dragProgress: 0

            function update(x) { dragProgress = Math.max(0, Math.min(1, x / width)); }

            onPressed: mouse => update(mouse.x)
            onPositionChanged: mouse => update(mouse.x)
            onReleased: MediaplayerService.seekTo(dragProgress)
            onClicked: {
                console.log(MediaplayerService.desktopEntry)
            }
        }
    }

    Row {
        anchors.top: parent.top
        anchors.topMargin: 110
        anchors.right: parent.right
        anchors.rightMargin: 50
        width: 150
        height: 60
        spacing: 5
        Rectangle {
            id: left
            anchors.verticalCenter: parent.verticalCenter
            width: leftButton.pressed ? 70
                : rightButton.pressed ? 30
                : middleButton.pressed ? 30
                : 50
            height: 50
            radius: width / 3
            color: hovered ? Qt.lighter(Theme.primary, 1.3) : Theme.primary
            property bool hovered: false
            Behavior on color{
                ColorAnimation{
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Spring on width {}
            MaterialIcon {
                anchors.centerIn: parent
                name: "play_arrow"
                color: Theme.secondary
                fill: 1
                size: 42
            }
            MouseArea {
                id: leftButton
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    MediaplayerService.togglePlaying()
                }
                onEntered: {
                    left.hovered = true
                }
                onExited: {
                    left.hovered = false
                }
            }
        }
        Rectangle {
            id: middle
            anchors.verticalCenter: parent.verticalCenter
            width: middleButton.pressed ? 70
                : rightButton.pressed ? 30
                : leftButton.pressed ? 30
                : 50
            height: 50
            radius: width / 3
            color: hovered ? Qt.lighter(Theme.primary, 1.3) : Theme.primary
            property bool hovered: false
            Behavior on color{
                ColorAnimation{
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Spring on width {}
            MaterialIcon {
                anchors.centerIn: parent
                name: "play_arrow"
                color: Theme.secondary
                fill: 1
                size: 42
            }
            MouseArea {
                id: middleButton
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    MediaplayerService.togglePlaying()
                }
                onEntered: {
                    middle.hovered = true
                }
                onExited: {
                    middle.hovered = false
                }
            }
        }
        Rectangle {
            id: right
            anchors.verticalCenter: parent.verticalCenter
            width: rightButton.pressed ? 70
                : leftButton.pressed ? 30
                : middleButton.pressed ? 30
                : 50
            height: 50
            radius: width / 3
            color: hovered ? Qt.lighter(Theme.secondary, 1.3) : Theme.secondary
            property bool hovered: false
            Spring on width {}
            Behavior on color{
                ColorAnimation{
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            MaterialIcon {
                anchors.centerIn: parent
                name: "skip_next"
                color: Theme.primary
                fill: 1
                size: 42
            }
            MouseArea {
                id: rightButton
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    MediaplayerService.next()
                }
                onEntered: {
                    right.hovered = true
                }
                onExited: {
                    right.hovered = false
                }
            }
        }
    }
}
