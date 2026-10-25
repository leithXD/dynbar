import Quickshell
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.Core
import qs.Components

Item {
    id: root
    required property var pill
    implicitWidth: 600
    implicitHeight: {
        if (list.count < 8) {
            if (list.count === 0) {
                return 200
            }
            return list.count * 71 + 120
        } else {
            return 650
        }
    }
    ClippingRectangle {
        width: 580
        height: root.implicitHeight - 22
        Spring on height{}
        radius: 10
        anchors.centerIn: parent
        color: "transparent"
        ScriptModel {
            id: results
            values: {
                const q = search.text.toLowerCase();
                return DesktopEntries.applications.values
                    .filter(e => !e.noDisplay && (
                        e.name.toLowerCase().includes(q) ||
                        e.genericName.toLowerCase().includes(q) ||
                        e.keywords.some(k => k.toLowerCase().includes(q))))
                    .sort((a, b) => a.name.localeCompare(b.name));
            }
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            TextField {
                id: search
                width: 470
                height: 40
                Component.onCompleted: search.forceActiveFocus()
                background: Rectangle {
                    MaterialIcon {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        name: "search"
                        color: Colors.md3.inverse_on_surface
                    }
                    anchors.centerIn: parent
                    radius: 15
                    color: Colors.transparency(Colors.md3.surface_variant, 0.3)
                    width: search.width + 80
                }
                color: Colors.md3.on_surface
                Keys.onDownPressed: list.incrementCurrentIndex()
                Keys.onUpPressed: list.decrementCurrentIndex()
                Keys.onEscapePressed: pill.toggleLauncher()
                onAccepted: root.activate()
            }
        }

        ClippingRectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            width: search.width + 80
            height: parent.height - 93
            radius: 10
            color: "transparent"
            Text {
                anchors.centerIn: parent
                text: "No results found"
                font.family: "Rubik"
                font.pointSize: 28
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)
                opacity: list.count === 0 ? 1 : 0
                Spring on opacity{}
            }
            ListView {
                id: list
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                model: results
                spacing: 1
                highlightMoveDuration: 100
                Component.onCompleted: {
                    pill.launcherCount = 8
                }
                onCountChanged: {
                    pill.launcherCount = Math.min(list.count, 8)
                }
                delegate: Rectangle {
                    id: rect
                    required property var modelData
                    readonly property string iconSrc: Quickshell.iconPath(modelData?.icon ?? "", true)
                    width: list.width
                    height: 70
                    radius: 15
                    color: ListView.isCurrentItem ? Colors.transparency(Colors.md3.secondary, 0.5) : Colors.transparency(Colors.md3.surface_variant, 0.3)
                    clip: true
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    Item {
                        anchors.topMargin: 15
                        anchors.leftMargin: 20
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 40
                        height: 40
                        Image {
                            id: icon
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            source:  rect.iconSrc
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            mipmap: true
                            asynchronous: true
                            visible: rect.iconSrc !== ""
                        }
                        MaterialIcon {
                            anchors.centerIn: icon
                            size: 32
                            name: "error"
                            color: Colors.md3.surface_variant
                            visible: rect.iconSrc === ""
                        }
                    }

                    Text {
                        text: modelData.name
                        color: Colors.md3.on_surface
                        font.bold: true
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.leftMargin: 80
                        Keys.onEnterPressed: {
                            root.activate()
                        }
                    }
                    Text {
                        text: modelData.comment
                        color: Colors.md3.on_surface
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 35
                        anchors.leftMargin: 80
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.activate()
                        }
                    }
                }
                populate: Transition {
                    SequentialAnimation {
                        PauseAnimation { duration: ViewTransition.index * 25 }
                        ParallelAnimation {
                            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
                            NumberAnimation { property: "y"; from: ViewTransition.destination.y + 12; duration: 200; easing.type: Easing.OutCubic }
                        }
                    }
                }
                add: Transition {
                    ParallelAnimation {
                        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 180 }
                        NumberAnimation { property: "scale"; from: 0.92; to: 1; duration: 180; easing.type: Easing.OutCubic }
                    }
                }
                remove: Transition {
                    NumberAnimation { property: "opacity"; to: 0; duration: 120 }
                }
                displaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 180; easing.type: Easing.OutCubic }
                }
            }
        }
    }
    function activate() {
        const entry = results.values[list.currentIndex]
        if (!entry) return
        entry.execute()
        pill.toggleLauncher()
    }
}
