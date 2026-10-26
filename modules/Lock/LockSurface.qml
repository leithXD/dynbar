import M3Shapes
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Core

WlSessionLockSurface {
    id: surface

    required property string screenCopy
    property bool bgReady: bg.status === Image.Ready

    signal unlockRequested()

    color: "black"

    Image {
        id: bg

        anchors.fill: parent
        cache: false
        fillMode: Image.PreserveAspectCrop
        source: surface.screenCopy
        visible: surface.bgReady
    }

    MultiEffect {
        anchors.fill: bg
        source: bg
        blurEnabled: true
        blur: surface.bgReady ? 1 : 0
        blurMax: 64
        blurMultiplier: 1
        autoPaddingEnabled: false

        Behavior on blur {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutCubic
            }

        }

    }

    ClippingRectangle {
        id: mainCard

        color: Colors.transparency(Colors.md3.surface, 0.8)
        x: (1920 - width) / 2
        y: (1080 - height) / 2
        opacity: surface.bgReady ? 1 : 0
        scale: surface.bgReady ? 1 : 0.2
        width: 1000
        height: 580
        radius: 40

        Timer {
            id: endAnim

            interval: 600
            running: surface.bgReady
            onTriggered: mainCard.width = 1200
        }

        RowLayout {
            id: lockLayout

            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: leftRect

                Layout.preferredWidth: 470
                Layout.fillHeight: true
                radius: 30
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0)

                Item {
                    id: avatar

                    width: img.width
                    height: img.height

                    Image {
                        id: img

                        source: Shellstate.avatar
                        visible: false
                        width: 230
                        height: 230
                        fillMode: Image.PreserveAspectCrop
                        antialiasing: true
                        mipmap: true
                        // sourceSize: Qt.size(192, 192)
                        smooth: true
                    }

                    MaterialShape {
                        id: shape

                        width: img.width
                        height: img.height
                        shape: MaterialShape.Cookie6Sided
                        color: Colors.md3.primary
                        layer.enabled: true
                        layer.smooth: true
                    }

                    MultiEffect {
                        anchors.fill: img
                        source: img
                        maskEnabled: true
                        maskSource: shape
                    }

                }

            }

            Rectangle {
                id: rightRect

                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 30
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)
            }

        }

        Spring on scale {
            duration: 600
        }

        Spring on width {
        }

        Smooth on opacity {
        }

    }

    Rectangle {
        id: button

        width: 180
        height: 56
        radius: height / 2
        color: area.containsMouse ? Qt.lighter(Colors.md3.primary, 1.2) : Colors.md3.primary
        scale: area.pressed ? 0.95 : 1

        Text {
            anchors.centerIn: parent
            text: "Entsperren"
            color: Colors.md3.on_primary
            font.family: "Rubik"
            font.pixelSize: 16
            font.weight: Font.DemiBold
        }

        MouseArea {
            id: area

            anchors.fill: parent
            hoverEnabled: true
            onClicked: surface.unlockRequested()
        }

        Behavior on color {
            ColorAnimation {
                duration: 150
            }

        }

        Behavior on scale {
            NumberAnimation {
                duration: 120
            }

        }

    }

}
