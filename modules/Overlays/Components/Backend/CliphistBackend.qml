import QtQuick
import Quickshell.Io

Item {
    id: clipBackend

    property alias model: clipListModel

    function parseAndFill(rawOutput) {
        clipListModel.clear();
        let lines = rawOutput.trim().split("\n");
        for (let i = 0; i < lines.length; i++) {
            let line = lines[i];
            if (line.trim() === "")
                continue;

            let tabIndex = line.indexOf("\t");
            if (tabIndex !== -1) {
                let entryId = line.substring(0, tabIndex);
                let entryContent = line.substring(tabIndex + 1);
                clipListModel.append({
                    "id": entryId,
                    "content": entryContent
                });
            }
        }
    }

    ListModel {
        id: clipListModel
    }

    Process {
        id: clipProc

        running: true
        command: ["cliphist", "list"]

        stdout: StdioCollector {
            onStreamFinished: {
                clipBackend.parseAndFill(this.text);
            }
        }

    }

}
