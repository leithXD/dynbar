import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Components
import qs.Core
import qs.Services

RowLayout {
    id: root

    property string activePill

    anchors.fill: parent
    spacing: 5

    Item {
        Layout.fillWidth: true

        Spring on Layout.preferredWidth {
        }

    }

    Loader {
        id: battery

        property real slot: item ? item.implicitWidth : 0

        active: true
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "battery_android_full" // from _0 to _6 to _full
            text: "bat"
            color: Colors.md3.tertiary
        }

        Spring on slot {
        }

    }

    Loader {
        id: ram

        property real slot: item ? item.implicitWidth : 0

        active: true
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "memory_alt"
            text: SysmonService.ramUsage
            color: Colors.md3.tertiary
            padding: 45
        }

        Spring on slot {
        }

    }

    Loader {
        id: cpu

        property real slot: item ? item.implicitWidth : 0

        active: true
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "memory"
            text: SysmonService.cpuUsage
            color: Colors.md3.tertiary
        }

        Spring on slot {
        }

    }

    Loader {
        id: bluetooth

        readonly property bool wanted: ConnectionService.bluetoothEnabled
        property real slot: wanted && item ? item.implicitWidth : 0

        active: wanted || slot > 0.5
        Layout.preferredHeight: 30
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: IconChip {
            icon: ConnectionService.bluetoothConnected ? "bluetooth_connected" : "bluetooth"
            color: ConnectionService.bluetoothConnected ? Colors.md3.tertiary : Colors.md3.on_surface
            opacity: wanted ? 1 : 0
            scale: wanted ? 1 : 0.1
            onClicked: {
                ConnectionService.toggleBluetooth();
            }

            Spring on scale {
            }

            Spring on opacity {
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }

            }

        }

        Spring on slot {
        }

    }

    Loader {
        // ConnectionService.toggleWifi() kinda broken

        id: wifi

        readonly property bool wanted: ConnectionService.wifiConnected
        property real slot: wanted && item ? item.implicitWidth : 0

        active: wanted || slot > 0.5
        Layout.preferredHeight: 30
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: IconChip {
            icon: "wifi"
            color: Colors.md3.on_surface
            opacity: wanted ? 1 : 0
            scale: wanted ? 1 : 0.1
            onClicked: {
            }

            Spring on scale {
            }

            Spring on opacity {
            }

        }

        Spring on slot {
        }

    }

    Loader {
        id: playButtons

        readonly property bool wanted: root.activePill !== "mediaplayer" && MediaplayerService.activePlayer !== null
        property real slot: wanted ? (item ? item.implicitWidth + 10 : 0) : 0

        active: wanted || slot > 0.5
        Layout.preferredHeight: 30
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: PlaybackButtons {
            opacity: wanted ? 1 : 0
            scale: wanted ? 1 : 0.1

            Spring on scale {
            }

            Spring on opacity {
            }

        }

        Spring on slot {
        }

    }

}
