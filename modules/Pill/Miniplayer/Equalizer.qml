import QtQuick
import Quickshell.Io
import qs.Core

Item {
    id: root
    implicitWidth: 380
    implicitHeight: 190

    property int barCount: 50
    property int barSpacing: 3
    property var levels: []

    function mix(a, b, t) {
        return Qt.rgba(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t,
                       a.b + (b.b - a.b) * t, 1);
    }

    // Audio-Daten via cava (raw ascii, 0-100)
    Process {
        running: true
        command: ["bash", "-c",
            "cava -p <(printf '[general]\\nbars=" + root.barCount +
            "\\nframerate=60\\n[output]\\nmethod=raw\\nraw_target=/dev/stdout" +
            "\\ndata_format=ascii\\nascii_max_range=100\\n')"]
        stdout: SplitParser {
            onRead: data => {
                const v = data.split(";").filter(s => s.length).map(Number);
                if (v.length >= root.barCount)
                    root.levels = v.slice(0, root.barCount);
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.barSpacing

        Repeater {
            model: root.barCount

            Rectangle {
                required property int index
                readonly property real level: (root.levels[index] ?? 0) / 100

                width: (root.width - root.barSpacing * (root.barCount - 1)) / root.barCount
                height: Math.max(width, level * root.height)
                anchors.verticalCenter: parent.verticalCenter
                radius: width / 2
                opacity: 0.55 + 0.45 * level
                color: root.mix(Theme.primary, Theme.tertiary,
                                index / (root.barCount - 1))

                Behavior on height {
                    NumberAnimation { duration: 90; easing.type: Easing.OutCubic }
                }
            }
        }
    }
}
