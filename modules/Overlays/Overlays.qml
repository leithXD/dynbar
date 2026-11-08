import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Core

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            id: root

            required property var modelData

            screen: modelData
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            exclusiveZone: 50
            WlrLayershell.layer: Config.settings.toastsFullscreen ? WlrLayer.Overlay : WlrLayer.Top
            WlrLayershell.namespace: "overlays"

            anchors {
                top: true
                right: true
                bottom: true
                left: true
            }

            Item {
                id: toastMask

                width: 450
                height: ToastsModel.count * 88
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 10

                ListView {
                    id: list

                    width: 450
                    height: 500
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    spacing: 8
                    model: ToastsModel
                    verticalLayoutDirection: ListView.BottomToTop
                    ListView.onRemove: console.log("remove", index)

                    remove: Transition {
                        NumberAnimation {
                            property: "scale"
                            from: 1
                            to: 0.2
                            duration: 300
                            easing.type: Easing.OutBack
                        }

                        NumberAnimation {
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 200
                            easing.type: Easing.OutBack
                        }

                    }

                    removeDisplaced: Transition {
                        NumberAnimation {
                            properties: "y"
                            duration: 300
                            easing.type: Easing.OutQuad
                        }

                    }

                    populate: Transition {
                        NumberAnimation {
                            property: "scale"
                            from: 0.2
                            to: 1
                            duration: 300
                            easing.type: Easing.OutBack
                        }

                        NumberAnimation {
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 200
                            easing.type: Easing.OutBack
                        }

                    }

                    add: Transition {
                        NumberAnimation {
                            property: "scale"
                            from: 0.2
                            to: 1
                            duration: 300
                            easing.type: Easing.OutBack
                        }

                        NumberAnimation {
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 200
                            easing.type: Easing.OutBack
                        }

                    }

                    delegate: Rectangle {
                        id: rect

                        width: 450
                        height: 80
                        radius: 30
                        color: Colors.surfaceColor
                        Component.onCompleted: {
                            dismissToast.running = true;
                        }

                        Timer {
                            id: dismissToast

                            running: false
                            repeat: false
                            interval: 5000
                            onTriggered: {
                                ToastsModel.remove(index);
                            }
                        }

                        Rectangle {
                            width: 65
                            height: 65
                            radius: 20
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 7
                            color: Colors.layer(Colors.md3.inverse_on_surface, 2)

                            MaterialIcon {
                                name: icon
                                anchors.centerIn: parent
                                color: Colors.md3.primary_container
                                size: 42
                            }

                        }

                        Column {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: 25
                            spacing: 5

                            Text {
                                id: head

                                text: name
                                font: Typography.titleMedium
                                color: Colors.md3.secondary
                            }

                            Text {
                                id: desc

                                text: description
                                font: Typography.bodyMedium
                                color: Colors.md3.on_surface
                                width: 360
                                wrapMode: Text.Wrap
                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                ToastsModel.remove(index);
                            }
                        }

                    }

                }

            }

            mask: Region {
                item: toastMask
            }

        }

    }

}
