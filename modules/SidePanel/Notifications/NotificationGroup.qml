import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.Core
import qs.Services

Item {
    id: root

    anchors.fill: parent

    Item {
        width: root.width - 10
        height: root.height
        anchors.centerIn: parent

        ListView {
            id: listView

            clip: true
            anchors.fill: parent
            topMargin: 5
            spacing: 4
            model: NotificationService.trackedNotifications

            delegate: Rectangle {
                width: listView.width
                height: 80
                x: 20
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)
                radius: 15
            }

            add: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 400
                    }

                    NumberAnimation {
                        property: "scale"
                        from: 0.1
                        to: 1
                        duration: 400
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
                    }

                }

            }

        }

    }

}
