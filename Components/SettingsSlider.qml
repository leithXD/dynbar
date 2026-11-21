import QtQuick
import QtQuick.Controls
import Quickshell.Io
import qs.Core

Item {
    // handle and background is pretty much ai

    id: root

    required property JsonObject targetObject
    required property string targetProperty
    property alias from: slider.from
    property alias to: slider.to
    property alias stepSize: slider.stepSize
    property string type

    width: 300
    height: 50

    Slider {
        // use slider.activeFocus

        id: slider

        property int gap: 5
        property bool showValue

        anchors.fill: parent
        snapMode: Slider.SnapAlways
        value: root.targetObject[root.targetProperty]
        onPressedChanged: {
            if (pressed)
                slider.showValue = true;

            if (!pressed) {
                root.targetObject[root.targetProperty] = slider.value;
                Config.saveSettings();
                showValueTimer.restart();
            }
        }

        Timer {
            id: showValueTimer

            interval: 300
            running: false
            repeat: false
            onTriggered: slider.showValue = false
        }

        background: Item {
            id: trackContainer

            readonly property int trackHeight: 20
            readonly property int handleSize: 3
            readonly property real handleX: slider.visualPosition * (width - handleSize)

            x: slider.leftPadding
            y: slider.topPadding
            width: slider.availableWidth
            height: slider.availableHeight

            Rectangle {
                readonly property real endX: trackContainer.handleX - slider.gap

                x: 0
                y: (parent.height - height) / 2
                width: Math.max(0, Math.min(endX, trackContainer.handleX))
                height: trackContainer.trackHeight
                radius: height / 2
                topRightRadius: radius / 2
                bottomRightRadius: radius / 2
                color: Colors.md3.primary
            }

            Rectangle {
                readonly property real startX: trackContainer.handleX + trackContainer.handleSize + slider.gap

                x: Math.min(startX, parent.width)
                y: (parent.height - height) / 2
                width: Math.max(0, parent.width - x)
                height: trackContainer.trackHeight
                radius: height / 2
                topLeftRadius: radius / 2
                bottomLeftRadius: radius / 2
                color: Colors.md3.surface_variant

                Rectangle {
                    height: 4
                    width: 4
                    radius: height / 2
                    color: Colors.md3.primary
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }

            }

        }

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 3
            implicitHeight: 40
            radius: 20
            color: Colors.md3.primary
            scale: slider.pressed ? 1.15 : (slider.hovered ? 1.05 : 1)

            Rectangle {
                property int gap: 10

                width: 25
                height: 25
                radius: height / 2
                color: Colors.md3.surface_variant
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: slider.showValue ? 1 : 0
                y: -height - gap

                Text {
                    color: Colors.md3.on_surface_variant
                    anchors.centerIn: parent
                    text: Math.round(slider.value * 100) / 100
                    font: Typography.labelSmall
                    scale: 0.9
                }

                Anim on opacity {
                    state: "smooth"
                }

            }

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }

            }

        }

    }

}
