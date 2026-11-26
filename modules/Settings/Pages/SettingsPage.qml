import QtQuick
import Quickshell.Io
import qs.Components
import qs.Core

Item {
    id: root

    property alias model: settings.model
    required property JsonObject targetObject

    anchors.fill: parent

    ListView {
        id: settings

        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        delegate: SettingsRow {
            required property var modelData

            height: 65
            width: parent.width
            radius: 20
            title: modelData.title
            desc: modelData.desc
            targetProperty: modelData.targetProperty
            targetObject: root.targetObject
            type: modelData.type
            from: modelData.from ?? 0
            to: modelData.to ?? 0
            stepSize: modelData.stepSize ?? 0
            color: Colors.layer(Colors.md3.surface_container_high)
        }

    }

}
