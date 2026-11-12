import QtQuick
import Quickshell.Io

Item {
    id: clipBackend

    property var entries: []

    function reload() {
        clipProc.running = true;
    }

    function parseAndFill(rawOutput) {
        const lines = rawOutput.trim().split("\n");
        const parsed = [];
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            const tabIndex = line.indexOf("\t");
            if (tabIndex !== -1) {
                const id = line.substring(0, tabIndex);
                const content = line.substring(tabIndex + 1);
                const isBinary = content.includes("[[ binary data");
                parsed.push({
                    "name": id,
                    "comment": content,
                    "icon": isBinary ? "image" : "content_copy"
                });
            }
        }
        clipBackend.entries = parsed;
    }

    Process {
        id: clipProc

        running: true
        command: ["cliphist", "list"]

        stdout: StdioCollector {
            onStreamFinished: clipBackend.parseAndFill(this.text)
        }

    }

}
