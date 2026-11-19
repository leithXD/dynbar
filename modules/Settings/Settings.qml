import "Pages"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core

FloatingWindow {
    id: win

    title: "Dynbar Settings"
    implicitWidth: 1200
    implicitHeight: 700
    visible: true
    onClosed: Shellstate.settingsOpened = false
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Colors.md3.surface
        radius: 30
    }

    Item {
        id: container

        property int page: 0

        anchors.fill: parent
        anchors.margins: 10

        RowLayout {
            anchors.fill: parent
            spacing: 10

            ClippingRectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                radius: 30
                color: Colors.layer(Colors.md3.inverse_on_surface, 2)

                Column {
                    anchors.margins: 10
                    anchors.fill: parent
                    spacing: 5

                    Rectangle {
                        width: parent.width
                        height: 65
                        radius: 30 - parent.anchors.margins
                        color: Colors.md3.surface

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                container.page = 0;
                            }
                        }

                    }

                    Rectangle {
                        width: parent.width
                        height: 65
                        radius: 30 - parent.anchors.margins
                        color: Colors.md3.surface

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                container.page = 1;
                            }
                        }

                    }

                    Rectangle {
                        width: parent.width
                        height: 65
                        radius: 30 - parent.anchors.margins
                        color: Colors.md3.surface

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                container.page = 2;
                            }
                        }

                    }

                    Rectangle {
                        width: parent.width
                        height: 65
                        radius: 30 - parent.anchors.margins
                        color: Colors.md3.surface

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                container.page = 3;
                            }
                        }

                    }

                }

            }

            ClippingRectangle {
                // here you can make new pages, give them a model, an object and an index so they can show up

                Layout.fillHeight: true
                Layout.preferredWidth: 750
                radius: 30
                color: Colors.layer(Colors.md3.inverse_on_surface, 2)

                PageLoader {
                    id: barSettings

                    page: container.page
                    index: 0

                    sourceComponent: SettingsPage {
                        model: Config.pillModel
                        targetObject: Config.pill
                    }

                }

                PageLoader {
                    id: pillSettings

                    page: container.page
                    index: 1

                    sourceComponent: SettingsPage {
                        model: Config.barModel
                        targetObject: Config.bar
                    }

                }

                PageLoader {
                    id: servicesSettings

                    page: container.page
                    index: 2

                    sourceComponent: SettingsPage {
                        model: Config.servicesModel
                        targetObject: Config.services
                    }

                }

                PageLoader {
                    id: appearanceSettings

                    page: container.page
                    index: 3

                    sourceComponent: SettingsPage {
                        model: Config.appearanceModel
                        targetObject: Config.appearance
                    }

                }

            }

        }

    }

}
