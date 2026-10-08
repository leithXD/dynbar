import QtQuick

Behavior {
    id: root
    property int duration: 400
    property var easingCurve: [0.38, 1.21, 0.22, 1, 1, 1]

    NumberAnimation {
        duration: root.duration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: root.easingCurve
    }
}
