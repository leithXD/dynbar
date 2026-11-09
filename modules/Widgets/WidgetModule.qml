import M3Shapes
import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core

Item {
    id: root

    property int radius: 30
    property string color: Colors.surfaceColor
    property bool shapeEnabled: false
    property int shape: MaterialShape.Cookie6Sided
    required property Component widget

    Loader {
        active: root.shapeEnabled

        sourceComponent: Item {
            ClippingShape {
                // layer.enabled: true
                // layer.smooth: true

                id: shape

                width: root.width
                height: root.height
                shape: root.shape
                color: root.color

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
