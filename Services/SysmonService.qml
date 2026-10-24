import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property int cpuUsage: 0
    property int ramUsage: 0
    property double totalRam: 0
    property double usedRam: 0
    property double lastCpuIdle: 0
    property double lastCpuTotal: 0

    function parse(text) {
        const lines = text.trim().split("\n");
        const cpuLine = lines.find((l) => {
            return l.startsWith("cpu ");
        });
        if (cpuLine) {
            const p = cpuLine.trim().split(/\s+/).slice(1, 8).map((n) => {
                return parseInt(n) || 0;
            });
            const total = p.reduce((a, b) => {
                return a + b;
            }, 0);
            const idle = p[3] + p[4];
            if (lastCpuTotal > 0) {
                const dTotal = total - lastCpuTotal;
                const dIdle = idle - lastCpuIdle;
                if (dTotal > 0)
                    cpuUsage = Math.round(100 * (dTotal - dIdle) / dTotal);

            }
            lastCpuTotal = total;
            lastCpuIdle = idle;
        }
        const kb = (key) => {
            const l = lines.find((x) => {
                return x.startsWith(key + ":");
            });
            return l ? (parseInt(l.split(/\s+/)[1]) || 0) : 0;
        };
        const memTotal = kb("MemTotal");
        const memAvailable = kb("MemAvailable");
        if (memTotal > 0) {
            const memUsed = memTotal - memAvailable;
            totalRam = Math.round(memTotal / 1024);
            usedRam = Math.round(memUsed / 1024);
            ramUsage = Math.round(100 * memUsed / memTotal);
        }
    }

    Process {
        id: proc

        command: ["sh", "-c", "head -n1 /proc/stat; grep -E 'MemTotal|MemAvailable' /proc/meminfo"]

        stdout: StdioCollector {
            onStreamFinished: root.parse(text)
        }

    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!proc.running)
                proc.running = true;

        }
    }

}
