import Quickshell
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.Core
import qs.Components

Item {
    id: root
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
                    anchors.centerIn: parent
                    radius: 15
                    color: Theme.subComponents
                    width: search.width + 80
                }
                Keys.onDownPressed: list.incrementCurrentIndex()
                Keys.onUpPressed: list.decrementCurrentIndex()
                Keys.onEscapePressed: Shellstate.toggleLauncher()
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
                color: Theme.text
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
                Component.onCompleted: {
                    Shellstate.launcherCount = 8
                }
                onCountChanged: {
                    Shellstate.launcherCount = Math.min(list.count, 8)
                }
                delegate: Rectangle {
                    required property var modelData
                    width: list.width
                    height: 70
                    radius: 15
                    color: ListView.isCurrentItem ? Theme.surfaceVariant : Theme.subComponents
                    clip: true
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                    Text {
                        text: modelData.name
                        color: Theme.text
                        font.bold: true
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.leftMargin: 20
                        Keys.onEnterPressed: {
                            root.activate()
                        }
                    }
                    Text {
                        text: modelData.comment
                        color: Theme.text
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 35
                        anchors.leftMargin: 20
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
        Shellstate.toggleLauncher()
    }
}
