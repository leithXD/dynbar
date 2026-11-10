import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core

Item {
    id: root

    property bool pendingAnimation: false
    property bool animationEnded
    property int animation

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
        root.animationEnded = !root.animationEnded;
    }

    anchors.fill: parent
    onAnimationEndedChanged: {
        var cleanPath = Shellstate.wallpaper.toString().replace("file://", "");
        Quickshell.execDetached(["skwd-paper-v2", "apply", "*", cleanPath]);
    }
    onPendingAnimationChanged: {
        if (animation === 0)
            animation = Math.floor(Math.random() * (5 - 1)) + 1;
        else
            animation = 0;
    }

    Connections {
        function onWallpaperChanged() {
            root.pendingAnimation = true;
        }

        target: Shellstate
    }

    WallpaperShape {
        id: shapeMask
    }

    WallpaperShape {
        id: shapeMask2
    }

    SequentialAnimation {
        // ScriptAction {
        // } just make smth that triggers the new wallpaper and destroys the one in use
        id: popupAnim

        running: root.animation === 1

        ScriptAction {
            script: {
                root.resetMasks();
                shapeMask.shape = Shapes.shapes[Math.floor(Math.random() * (Shapes.shapes.length - 0)) + 0];
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: shapeMask
                properties: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 300
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskY"
                from: 1000
                to: 0
                easing.type: Easing.OutCubic
                duration: 300
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskScale"
                from: 0.2
                to: 1
                easing.type: Easing.OutBack
                duration: 300
            }

        }

        NumberAnimation {
            target: shapeMask
            properties: "maskScale"
            from: 1
            to: 3.5
            easing.type: Easing.OutBack
            duration: 400
        }

        ScriptAction {
            script: {
                root.pendingAnimation = false;
                root.endOfAnimation();
            }
        }

    }

    SequentialAnimation {
        id: rotateAnim

        running: root.animation === 2

        ScriptAction {
            script: {
                root.resetMasks();
                shapeMask.shape = Shapes.shapes[Math.floor(Math.random() * (Shapes.shapes.length - 0)) + 0];
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: shapeMask
                properties: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 300
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskX"
                from: -1000
                to: 0
                easing.type: Easing.OutCubic
                duration: 300
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskScale"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 300
            }

            NumberAnimation {
                target: shapeMask
                properties: "maskRotation"
                from: 0
                to: 360
                easing.type: Easing.OutCubic
                duration: 300
            }

        }

        NumberAnimation {
            target: shapeMask
            properties: "maskScale"
            to: 3
            easing.type: Easing.OutBack
            duration: 500
        }

        ScriptAction {
            script: {
                root.pendingAnimation = false;
                root.endOfAnimation();
            }
        }

    }

    SequentialAnimation {
        id: circleAnim

        running: root.animation === 3

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
                root.pendingAnimation = false;
                root.endOfAnimation();
            }
        }

    }

    SequentialAnimation {
        id: doubleCircleAnim

        running: root.animation === 4

        ScriptAction {
            script: {
                root.resetMasks();
                shapeMask.maskY = 500;
                shapeMask.maskX = 500;
                shapeMask2.maskY = -500;
                shapeMask2.maskX = -500;
                shapeMask.shape = Shapes.circle;
                shapeMask2.shape = Shapes.circle;
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

            NumberAnimation {
                target: shapeMask2
                properties: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCubic
                duration: 400
            }

            NumberAnimation {
                target: shapeMask2
                properties: "maskScale"
                from: 0.2
                to: 3.5
                easing.type: Easing.InOutCubic
                duration: 800
            }

        }

        ScriptAction {
            script: {
                root.pendingAnimation = false;
                root.endOfAnimation();
            }
        }

    }

}
