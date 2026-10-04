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
    property real fill: 0
    property int weight: 400

    width: size
    height: size
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    renderType: Text.NativeRendering
    antialiasing: true
    font.variableAxes: ({ "FILL": fill, "wght": weight })

    Behavior on color { ColorAnimation { duration: 150 } }
}
