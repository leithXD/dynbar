import QtQuick
import QtQuick.Controls
import Quickshell.Io
import qs.Core

Item {
    id: root

    required property JsonObject targetObject
    required property string targetProperty
    property alias from: slider.from
    property alias to: slider.to
    property alias stepSize: slider.stepSize
    property string type

    width: 300
    height: 50

    Slider {
        id: slider

        anchors.fill: parent
        from: 0
        to: 1
        stepSize: 0.05
        snapMode: Slider.SnapAlways
        value: root.targetObject[root.targetProperty]
        onPressedChanged: {
            if (!pressed) {
                root.targetObject[root.targetProperty] = slider.value;
                Config.saveSettings();
            }
        }
    }

}
