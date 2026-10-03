import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Core
import M3Shapes

ClippingRectangle {
    id: root
    anchors.centerIn: parent
    visible: loading
    property bool loading: false
    property int duration: 500
    property int spacing: 10
    property string primaryColor: Theme.primary
    property string primaryColorAlt: Theme.primaryAlt
    property int i: 0
    property var shapes: [
        MaterialShape.Circle,
        MaterialShape.Square,
        MaterialShape.SemiCircle,
        MaterialShape.Oval,
        MaterialShape.Pill,
        MaterialShape.Triangle,
        MaterialShape.Diamond,
        MaterialShape.Pentagon,
        MaterialShape.Gem,
        MaterialShape.Sunny,
        MaterialShape.VerySunny,
        MaterialShape.Cookie4Sided,
        MaterialShape.Cookie6Sided,
        MaterialShape.Clover4Leaf,
        MaterialShape.SoftBurst,
        MaterialShape.Flower,
        MaterialShape.Puffy,
    ]

    color: primaryColorAlt
    radius: width / 2

    MaterialShape {
        id: shape
        anchors.centerIn: parent
        width: root.width - root.spacing
        height: root.height - root.spacing
        shape: MaterialShape.Circle
        color: root.primaryColor
        Spring on scale{}
        Spring on rotation{}
    }

    Timer {
        interval: root.duration
        repeat: true
        onTriggered: {
            root.i++
            shape.shape = root.shapes[root.i]
            if (root.i === 16) {
                root.i = 0
            }
            scaleAnim.running = true
        }
        running: root.loading
    }

    SequentialAnimation {
        id: scaleAnim

        running: false

        NumberAnimation {
            target: shape
            property: "scale"
            to: 1.2
            duration: 100
        }
        NumberAnimation {
            target: shape
            property: "scale"
            to: 1
            duration: 100
        }
    }
}
