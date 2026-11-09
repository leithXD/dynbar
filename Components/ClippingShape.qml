import M3Shapes
import QtQuick

Item {
    // ai
    id: root

    property int shape: MaterialShape.Cookie6Sided
    property color color: "transparent"
    default property alias content: container.data

    implicitWidth: 56
    implicitHeight: 56

    Item {
        id: container

        anchors.fill: parent
    }

    MaterialShape {
        id: mask

        anchors.fill: parent
        shape: root.shape
        color: "#ffff0000"
        layer.enabled: true
        visible: false
    }

    ShaderEffectSource {
        id: contentSource

        sourceItem: container
        hideSource: true
    }

    ShaderEffect {
        property var rect: mask
        property color backgroundColor: root.color
        property color borderColor: "transparent"
        property var content: contentSource

        anchors.fill: parent
        fragmentShader: "qrc:/Quickshell/Widgets/shaders/cliprect.frag.qsb"
    }

}
