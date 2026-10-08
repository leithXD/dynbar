import QtQuick

Behavior {
    id: root
    property int duration: 300
    property var easingCurve: [0.25, 0.1, 0.25, 1.0]

    NumberAnimation {
        duration: root.duration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: root.easingCurve
    }
}
