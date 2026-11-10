import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Core

Item {
    id: root

    property string cleanPath: {
        return Shellstate.wallpaper.toString().replace("file://", "");
    }

    function resetMasks() {
        shapeMask.maskScale = 0.2;
        shapeMask.maskX = 0;
        shapeMask.maskY = 0;
        shapeMask.opacity = 0;
        shapeMask2.maskScale = 0.2;
        shapeMask2.maskX = 0;
        shapeMask2.maskY = 0;
        shapeMask2.opacity = 0;
    }

    function endOfAnimation() {
        callWallpaper.running = true;
    }

    anchors.fill: parent
    Component.onCompleted: {
        circleAnim.restart();
    }

    Process {
        id: callWallpaper

        command: ["sh", "-c", "skwd-paper-v2 apply '*' " + root.cleanPath]

        stdout: StdioCollector {
            onStreamFinished: {
                Shellstate.wallpaperLoaderEnabled = false;
            }
        }

    }

    WallpaperShape {
        id: shapeMask
    }

    WallpaperShape {
        id: shapeMask2
    }

    SequentialAnimation {
        id: circleAnim

        ScriptAction {
            script: {
                root.resetMasks();
                shapeMask.maskY = Math.random() < 0.5 ? 500 : -500;
                shapeMask.maskX = Math.random() < 0.5 ? 500 : -500;
                shapeMask.shape = Shapes.circle;
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: shapeMask
                properties: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 400
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskScale"
                from: 0.2
                to: 3.5
                easing.type: Easing.InOutCubic
                duration: 800
            }

        }

        ScriptAction {
            script: {
                root.endOfAnimation();
            }
        }

    }

}
