import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    anchors.fill: parent

    ClippingRectangle {
        radius: 20
        color: "transparent"
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
            onCountChanged: {
                var calculatedHeight = listView.count * 84 + 10;
                Shellstate.sidePanelListHeight = Math.max(94, Math.min(calculatedHeight, 410));
            }

            delegate: Rectangle {
                id: delegateRect

                required property var modelData
                readonly property real initialX: 0

                width: listView.width
                height: 80
                color: Colors.transparency(Colors.md3.surface_variant, 0.2)
                radius: 15

                Text {
                    id: header

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    text: modelData.summary
                    color: Colors.md3.primary
                    font.family: "Rubik"
                }

                Text {
                    id: msg

                    width: 270
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 27
                    anchors.leftMargin: 10
                    text: modelData.body
                    color: Colors.md3.on_surface
                    font.family: "Rubik"
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    maximumLineCount: 3
                    textFormat: Text.PlainText
                }

                ClippingRectangle {
                    width: 40
                    height: 40
                    radius: width / 2
                    color: "transparent"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        anchors.fill: parent
                        source: modelData.image
                    }

                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    drag.target: delegateRect
                    drag.axis: Drag.XAxis
                    drag.minimumX: -listView.width
                    drag.maximumX: listView.width * 2
                    onReleased: {
                        var threshold = 220;
                        if (delegateRect.x < initialX - threshold) {
                            modelData.dismiss();
                        } else if (delegateRect.x > initialX + threshold) {
                            modelData.dismiss();
                        } else {
                            returnAnim.to = initialX;
                            returnAnim.start();
                        }
                    }
                }

                NumberAnimation {
                    id: returnAnim

                    target: delegateRect
                    property: "x"
                    duration: 200
                    easing.type: Easing.OutQuad
                }

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

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 400
                    }

                    NumberAnimation {
                        property: "scale"
                        from: 1
                        to: 0.1
                        duration: 400
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
                    }

                }

            }

            displaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 250
                    easing.type: Easing.OutQuad
                }

            }

        }

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 20
            anchors.leftMargin: 10
            text: "Nothing here..."
            font.family: "Rubik"
            font.bold: true
            font.pointSize: 28
            color: Colors.md3.on_surface
            opacity: listView.count === 0 ? 1 : 0

            Smooth on opacity {
                duration: 100
            }

        }

    }

}
