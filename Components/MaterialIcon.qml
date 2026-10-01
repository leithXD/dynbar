import QtQuick

Text {
    id: root

    property string name: ""
    property real size: 24
    property string family: "Material Symbols Rounded"
    property string iconColor

    text: name
    color: iconColor !== "" ? "white" : iconColor
    font.family: family
    font.pixelSize: size

    width: size
    height: size
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    renderType: Text.NativeRendering
    antialiasing: true

    Behavior on color { ColorAnimation { duration: 150 } }
}
