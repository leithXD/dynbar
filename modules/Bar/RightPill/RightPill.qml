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

        Anim on Layout.preferredWidth {
        }

    }

    Loader {
        id: temp

        property real slot: wanted && item ? item.implicitWidth : 0
        readonly property bool wanted: Config.bar.alwaysShowTemp || SysmonService.cpuTemp > 80

        active: wanted || slot > 0.5
        visible: active
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "device_thermostat"
            text: SysmonService.cpuTemp
            color: Colors.md3.tertiary
            padding: 20
            opacity: temp.wanted ? 1 : 0
            scale: temp.wanted ? 1 : 0.1

            Anim on scale {
            }

            Anim on opacity {
            }

        }

        Anim on slot {
        }

    }

    Loader {
        id: ram

        property real slot: wanted && item ? item.implicitWidth : 0
        readonly property bool wanted: Config.bar.alwaysShowRam || SysmonService.ramUsage > 75

        active: wanted || slot > 0.5
        visible: active
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "memory_alt"
            text: SysmonService.ramUsage
            color: Colors.md3.tertiary
            padding: 20
            opacity: ram.wanted ? 1 : 0
            scale: ram.wanted ? 1 : 0.1

            Anim on scale {
            }

            Anim on opacity {
            }

        }

        Anim on slot {
        }

    }

    Loader {
        id: cpu

        property real slot: item ? item.implicitWidth : 0

        active: true
        visible: active
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: StatChip {
            icon: "memory"
            text: SysmonService.cpuUsage
            color: Colors.md3.tertiary
        }

        Anim on slot {
        }

    }

    Loader {
        id: battery

        property real slot: item ? item.implicitWidth : 0

        active: true
        visible: active
        Layout.preferredHeight: 38
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: BatteryChip {
        }

        Anim on slot {
        }

    }

    Loader {
        id: bluetooth

        readonly property bool wanted: ConnectionService.bluetoothEnabled
        property real slot: wanted && item ? item.implicitWidth : 0

        active: wanted || slot > 0.5
        visible: active
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

            Anim on scale {
            }

            Anim on opacity {
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }

            }

        }

        Anim on slot {
        }

    }

    Loader {
        // ConnectionService.toggleWifi() kinda broken

        id: wifi

        readonly property bool wanted: ConnectionService.wifiConnected
        property real slot: wanted && item ? item.implicitWidth : 0

        active: wanted || slot > 0.5
        visible: active
        Layout.preferredHeight: 30
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: IconChip {
            icon: "wifi"
            color: Colors.md3.on_surface
            opacity: wanted ? 1 : 0
            scale: wanted ? 1 : 0.1
            onClicked: {
            }

            Anim on scale {
            }

            Anim on opacity {
            }

        }

        Anim on slot {
        }

    }

    Loader {
        id: playButtons

        readonly property bool wanted: root.activePill !== "mediaplayer" && MediaplayerService.activePlayer !== null
        property real slot: wanted ? (item ? item.implicitWidth : 0) : 0

        active: wanted || slot > 0.5
        visible: active
        Layout.preferredHeight: 30
        Layout.preferredWidth: Math.max(0, slot)

        sourceComponent: PlaybackButtons {
            opacity: wanted ? 1 : 0
            scale: wanted ? 1 : 0.1

            Anim on scale {
            }

            Anim on opacity {
            }

        }

        Anim on slot {
        }

    }

    Item {
        Layout.preferredWidth: 0 // spacer bc i am dumb
    }

}
