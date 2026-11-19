import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.Components
import qs.Core

RowLayout {
    id: row

    required property string title
    required property string desc
    required property JsonObject targetObject
    required property string targetProperty

    width: parent.width - 30

    Column {
        spacing: 3

        Text {
            text: row.title
            font: Typography.titleMedium
            color: Colors.md3.on_surface
        }

        Text {
            text: row.desc
            font: Typography.bodyMedium
            color: Colors.md3.on_surface
        }

    }

    Item {
        Layout.fillWidth: true
    }

    ToggleButton {
        targetObject: row.targetObject
        targetProperty: row.targetProperty
    }

}
