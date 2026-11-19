import QtQuick
import qs.Components
import qs.Core

Item {
    anchors.fill: parent

    ListView {
        anchors.fill: parent
        anchors.margins: 10
        model: Config.pillModel
        spacing: 5

        delegate: SettingsRow {
            required property var modelData

            height: 65
            width: parent.width
            radius: 20
            title: modelData.title
            desc: modelData.desc
            targetProperty: modelData.targetProperty
            targetObject: Config.pill
            type: modelData.type
            color: Colors.md3.surface
        }

    }

}
