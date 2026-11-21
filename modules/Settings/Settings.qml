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

                    Column {
                        anchors.fill: parent
                        spacing: 8

                        Repeater {
                            model: Config.settingsPages

                            delegate: ClippingRectangle {
                                id: rect

                                required property var modelData
                                required property int index
                                property bool selected: container.page === index

                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width - 10
                                height: 65
                                radius: height / 2
                                color: Colors.md3.surface
                                states: [
                                    State {
                                        name: "pressed"
                                        when: mouseArea.pressed

                                        PropertyChanges {
                                            target: rect
                                            width: parent.width
                                            radius: 10
                                            color: rect.selected ? Colors.md3.primary : Colors.md3.surface
                                        }

                                    },
                                    State {
                                        name: "selected"
                                        when: rect.selected

                                        PropertyChanges {
                                            target: rect
                                            width: parent.width - 10
                                            radius: height / 2
                                            color: Colors.md3.primary
                                        }

                                    }
                                ]

                                Column {
                                    id: column

                                    property color useColor: rect.selected ? Colors.md3.on_primary : Colors.md3.on_surface

                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 25
                                    spacing: 5

                                    Text {
                                        text: modelData.title
                                        font: Typography.titleMedium
                                        color: column.useColor
                                    }

                                    Text {
                                        text: modelData.desc
                                        font: Typography.bodyMedium
                                        color: Qt.darker(column.useColor, 1.5)
                                    }

                                }

                                MouseArea {
                                    id: mouseArea

                                    anchors.fill: parent
                                    onClicked: {
                                        container.page = index;
                                    }
                                }

                                Anim on radius {
                                }

                                Anim on width {
                                }

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 150
                                    }

                                }

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

                PageLoader {
                    id: generalSettings

                    page: container.page
                    index: 4

                    sourceComponent: SettingsPage {
                        model: Config.generalModel
                        targetObject: Config.settings
                    }

                }

            }

        }

    }

}
