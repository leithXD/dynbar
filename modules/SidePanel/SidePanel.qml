import "Notifications"
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
            property bool opened: false

            screen: modelData
            implicitHeight: 1080
            implicitWidth: 450
            color: "transparent"
            exclusionMode: ExclusionMode.Normal
            exclusiveZone: 50
            WlrLayershell.namespace: "Sidepanel"

            anchors {
                top: true
                right: true
            }

            Item {
                id: edge

                width: 6

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }

                DragHandler {
                    property bool fired: false

                    target: null
                    enabled: !root.opened
                    onTranslationChanged: {
                        if (active && translation.x < -80 && !fired) {
                            fired = true;
                            // console.log("fired, translation:", translation.x);
                            root.opened = true;
                        }
                    }
                    onActiveChanged: {
                        if (!active)
                            fired = false;

                    }
                }

            }

            ClippingRectangle {
                id: panel

                width: 400
                height: 1010
                radius: 30
                anchors.top: parent.top
                anchors.topMargin: 10
                x: root.opened ? 20 : 450
                color: Colors.transparency(Colors.md3.surface, 0.8)

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.opened = false
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: 380
                    height: 400
                    radius: 20
                    color: "transparent"

                    Notifications {
                    }

                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    width: 380
                    height: 990 - Shellstate.sidePanelListHeight
                    radius: 20
                    color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)

                    Spring on height {
                        duration: 500
                    }

                }

                Spring on x {
                }

            }

            mask: Region {
                item: panel

                Region {
                    item: edge
                }

            }

        }

    }

}
