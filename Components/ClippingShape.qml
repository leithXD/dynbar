import M3Shapes
import QtQuick

Item {
    // ai
    id: root

    property int shape: MaterialShape.Cookie6Sided
    property color color: "transparent"
    property real maskRotation: 0
    default property alias content: container.data

    implicitWidth: 56
    implicitHeight: 56

    Item {
        id: container

        anchors.fill: parent
    }

    Item {
        id: maskLayer

        anchors.fill: parent
        visible: false
        layer.enabled: true

        MaterialShape {
            id: mask

            anchors.fill: parent
            shape: root.shape
            color: "#ffff0000"
            rotation: root.maskRotation
        }

    }

    ShaderEffectSource {
        id: contentSource

        sourceItem: container
        hideSource: true
    }

    ShaderEffect {
        property var rect: maskLayer
        property color backgroundColor: root.color
        property color borderColor: "transparent"
        property var content: contentSource

        anchors.fill: parent
        fragmentShader: "qrc:/Quickshell/Widgets/shaders/cliprect.frag.qsb"
    }

}
