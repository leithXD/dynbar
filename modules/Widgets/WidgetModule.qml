import M3Shapes
import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.Core

Item {
    id: root

    property int radius: 30
    property string color: Colors.surfaceColor
    property bool shapeEnabled: false
    required property Component widget

    Loader {
        active: root.shapeEnabled

        sourceComponent: Item {
            MaterialShape {
                id: shape

                width: root.width
                height: root.height
                shape: MaterialShape.Cookie6Sided
                color: root.color
                layer.enabled: true
                layer.smooth: true

                Loader {
                    anchors.fill: parent
                    sourceComponent: root.widget
                }

            }

        }

    }

    Loader {
        active: !root.shapeEnabled

        sourceComponent: ClippingRectangle {
            width: root.width
            height: root.height
            radius: root.radius
            color: root.color

            Loader {
                anchors.fill: parent
                sourceComponent: root.widget
            }

        }

    }

}
