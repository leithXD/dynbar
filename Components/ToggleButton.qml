import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core

Item {
    id: root

    property bool active: targetObject ? Boolean(targetObject[targetProperty]) : false
    required property JsonObject targetObject
    required property string targetProperty

    signal clicked()

    function toggle() {
        if (targetObject) {
            targetObject[targetProperty] = !root.active;
            Config.saveSettings();
        }
    }

    onClicked: {
        toggle();
    }
    width: 70
    height: 35

    Rectangle {
        id: outerRect

        anchors.fill: parent
        color: root.active ? Colors.md3.primary : Colors.md3.surface_variant
        radius: height / 2

        Rectangle {
            // EDecel on x {
            // }

            width: 25
            height: 25
            radius: width / 2
            color: Colors.md3.inverse_on_surface
            anchors.verticalCenter: parent.verticalCenter
            x: root.active ? outerRect.width - 5 - width : 5

            Item {
                width: parent.width
                height: parent.height
                y: root.active ? 1 : 0

                Rectangle {
                    width: 1
                    height: root.active ? 12 : 8
                    color: Colors.md3.inverse_on_surface
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: root.active ? 3 : 0
                    anchors.verticalCenterOffset: root.active ? -2 : 0
                    rotation: 45

                    Anim on anchors.horizontalCenterOffset {
                        state: "emphasizedAccel"
                    }

                    Anim on anchors.verticalCenterOffset {
                        state: "emphasizedAccel"
                    }

                    Anim on height {
                        state: "emphasizedAccel"
                    }

                }

                Rectangle {
                    width: 1
                    height: root.active ? 6 : 8
                    color: Colors.md3.inverse_on_surface
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: root.active ? -3 : 0
                    rotation: -45

                    Anim on anchors.horizontalCenterOffset {
                        state: "emphasizedAccel"
                    }

                    Anim on height {
                        state: "emphasizedAccel"
                    }

                }

                Anim on y {
                }

            }

            Anim on x {
                state: "emphasized"
            }

        }

        Behavior on color {
            ColorAnimation {
                duration: 300
            }

        }

    }

    MouseArea {
        id: click

        anchors.fill: parent
        onClicked: {
            root.clicked();
        }
    }

}
