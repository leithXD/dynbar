import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Core

WlSessionLockSurface {
    id: surface

    // Zugriff auf root über den Kontext oder über ein Property,
    // das du von außen übergibst (oder direkt via scope/root wenn im gleichen Ordner geladen).
    // Am sichersten ist es, wenn wir den Snapshot direkt als Property reinreichen:
    required property string screenCopy
    property bool bgReady: bg.status === Image.Ready

    signal unlockRequested()

    color: "black"

    Image {
        id: bg

        anchors.fill: parent
        cache: false
        fillMode: Image.PreserveAspectCrop
        source: surface.screenCopy
        visible: surface.bgReady
    }

    MultiEffect {
        anchors.fill: bg
        source: bg
        blurEnabled: true
        blur: surface.bgReady ? 1 : 0
        blurMax: 64
        blurMultiplier: 1
        autoPaddingEnabled: false

        Behavior on blur {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutCubic
            }

        }

    }

    ClippingRectangle {
        id: mainCard

        color: Colors.transparency(Colors.md3.surface, 0.8)
        x: (1920 - width) / 2
        y: surface.bgReady ? (1080 - height) / 2 : (1080 - height) * 1.3
        opacity: surface.bgReady ? 1 : 0
        width: surface.bgReady ? 1000 : 200
        height: surface.bgReady ? 580 : 120
        radius: 30

        Spring on width {
        }

        Spring on height {
        }

        Spring on y {
        }

        Smooth on opacity {
        }

    }

    Rectangle {
        id: button

        width: 180
        height: 56
        radius: height / 2
        color: area.containsMouse ? Qt.lighter(Colors.md3.primary, 1.2) : Colors.md3.primary
        scale: area.pressed ? 0.95 : 1

        Text {
            anchors.centerIn: parent
            text: "Entsperren"
            color: Colors.md3.on_primary
            font.family: "Rubik"
            font.pixelSize: 16
            font.weight: Font.DemiBold
        }

        MouseArea {
            id: area

            anchors.fill: parent
            hoverEnabled: true
            onClicked: surface.unlockRequested()
        }

        Behavior on color {
            ColorAnimation {
                duration: 150
            }

        }

        Behavior on scale {
            NumberAnimation {
                duration: 120
            }

        }

    }

}
