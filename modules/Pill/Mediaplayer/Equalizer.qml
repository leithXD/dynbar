import QtQuick
import Quickshell.Io
import qs.Core

Item {
    id: root

    property int barCount: 50
    property int barSpacing: 3
    property int framerate: 30
    property color barColor: Colors.md3.primary
    property bool active: root.visible
    property var levels: new Array(50).fill(0)

    implicitWidth: 380
    implicitHeight: 300

    Process {
        running: root.active
        command: ["bash", "-c", "cava -p <(printf '[general]\\nbars=" + root.barCount + "\\nframerate=" + root.framerate + "\\n[output]\\nmethod=raw\\nraw_target=/dev/stdout\\ndata_format=ascii\\nascii_max_range=100\\n')"]

        stdout: SplitParser {
            onRead: (data) => {
                const raw = data.split(";");
                const next = new Array(root.barCount);
                let count = 0;
                for (let i = 0; i < raw.length && count < root.barCount; i++) {
                    const s = raw[i].trim();
                    if (s.length === 0)
                        continue;

                    const n = Number(s);
                    if (!Number.isNaN(n))
                        next[count++] = n;

                }
                if (count === root.barCount)
                    root.levels = next;

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
                readonly property real level: Math.min(1, Math.max(0, (root.levels[index] ?? 0) / 100))
                readonly property real barWidth: Math.max(1, (root.width - root.barSpacing * (root.barCount - 1)) / root.barCount)

                width: barWidth
                height: Math.max(barWidth, level * root.height)
                anchors.verticalCenter: parent.verticalCenter
                radius: barWidth * 0.5
                color: root.barColor
            }

        }

    }

}
