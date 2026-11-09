import M3Shapes
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    required property var pill

    implicitWidth: items.width + 10
    implicitHeight: 40

    Loader {
        active: Config.pill.blurArtwork
        anchors.fill: parent

        sourceComponent: BlurredArtwork {
        }

    }

    Loader {
        active: true

        sourceComponent: Equalizer {
            y: root.implicitHeight / 2 + 4
            scale: 1
            width: root.width
            height: root.height
            barCount: 40
            opacity: 0.4

            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    easing: Easing.OutBack
                }

            }

        }

    }

    RowLayout {
        id: items

        anchors.centerIn: parent
        spacing: 5

        ClippingShape {
            id: cover

            Layout.preferredWidth: 28
            Layout.preferredHeight: 28
            shape: MediaplayerService.isPlaying ? MaterialShape.Clover8Leaf : MaterialShape.Circle

            Image {
                id: coverImage

                anchors.fill: parent
                anchors.centerIn: parent
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
                size: 24
                color: Colors.md3.surface_variant
                visible: MediaplayerService.activePlayer === null
            }

            MaterialLoading {
                anchors.centerIn: parent
                loading: coverImage.status !== Image.Ready
                width: coverImage.width - 5
                height: coverImage.height - 5
                opacity: MediaplayerService.hasPlayer && coverImage.status !== Image.Ready ? 1 : 0

                Spring on opacity {
                }

            }

            NumberAnimation on maskRotation {
                from: 0
                to: 360
                duration: 32000
                loops: Animation.Infinite
                running: MediaplayerService.isPlaying
            }

        }

        Text {
            id: title

            text: MediaplayerService.activePlayer === null ? "Nothing is playing" : Format.cleanTitle(MediaplayerService.trackTitle, MediaplayerService.trackArtist)
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 1
            font: Typography.titleMedium
            color: Colors.md3.on_surface
            Layout.preferredWidth: Math.min(implicitWidth + 30, 400)
            horizontalAlignment: Text.AlignHCenter

            Spring on anchors.leftMargin {
            }

        }

        Row {
            id: buttons

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
                        pill.componentHover = true;
                        left.hovered = true;
                    }
                    onExited: {
                        pill.componentHover = false;
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
                        pill.componentHover = true;
                        right.hovered = true;
                    }
                    onExited: {
                        pill.componentHover = false;
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

}
