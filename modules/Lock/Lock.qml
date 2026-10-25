import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Core
import qs.Components

Scope {
    id: root

    property bool capturing: false

    property var snapshots: ({})
    property double t0: 0

    function engage() {
        if (capturing || sessionLock.locked)
            return
        snapshots = ({})
        t0 = Date.now()
        capturing = true
        timeout.restart()
    }

    function store(name, result) {
        const copy = Object.assign({}, snapshots)
        copy[name] = result
        snapshots = copy
        if (Object.keys(snapshots).length >= Quickshell.screens.length)
            finish()
    }

    function finish() {
        if (!capturing)
            return
        timeout.stop()
        capturing = false
        sessionLock.locked = true
    }

    Timer {
        id: timeout

        interval: 500
        onTriggered: root.finish()
    }

    IpcHandler {
        target: "lock"

        function lock(): void {
            root.engage()
        }

        function unlock(): void {
            sessionLock.locked = false
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: win

            required property var modelData

            screen: modelData
            visible: root.capturing
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            mask: Region {}
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            WlrLayershell.namespace: "lock-capture"

            ScreencopyView {
                id: shot

                function grab() {
                    const start = Date.now()
                    shot.grabToImage(result => {
                        root.store(win.screen.name, result)
                    }, shot.sourceSize)
                }

                anchors.fill: parent
                live: false

                captureSource: win.visible && Quickshell.screens.includes(win.screen) ? win.screen : null

                onHasContentChanged: {
                    if (!hasContent)
                        return
                    Qt.callLater(grab)
                }
            }
        }
    }

    WlSessionLock {
        id: sessionLock
        LockSurface {
            id: surface
            screenCopy: root.snapshots[surface.screen?.name]?.url ?? ""

            onUnlockRequested: {
                sessionLock.locked = false
            }
        }

    }
}

