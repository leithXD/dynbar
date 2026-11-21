import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.Components
import qs.Core

Rectangle {
    id: root

    property var targetObject
    property string targetProperty
    required property string title
    required property string desc
    required property string type
    property real from
    property real to
    property real stepSize

    anchors.horizontalCenter: parent.horizontalCenter

    RowLayout {
        id: row

        anchors.centerIn: parent
        width: root.width - 20

        Column {
            spacing: 5

            Text {
                text: root.title
                font: Typography.titleMedium
                color: Colors.md3.on_surface
            }

            Text {
                text: root.desc
                font: Typography.bodyMedium
                color: Colors.md3.on_surface
            }

        }

        Item {
            Layout.fillWidth: true
        }

        Loader {
            active: root.type === "toggle"

            sourceComponent: ToggleButton {
                id: toggle

                targetProperty: root.targetProperty
                targetObject: root.targetObject
            }

        }

        Loader {
            active: root.type === "input"

            sourceComponent: InputField {
                id: inputField

                targetProperty: root.targetProperty
                targetObject: root.targetObject
            }

        }

        Loader {
            active: root.type === "slider"

            sourceComponent: SettingsSlider {
                id: slider

                targetProperty: root.targetProperty
                targetObject: root.targetObject
                from: root.from
                to: root.to
                stepSize: root.stepSize
            }

        }

    }

}
