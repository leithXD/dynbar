pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Networking

Singleton {
    id: root

    readonly property bool wifiEnabled: Networking.wifiEnabled

    readonly property var activeNetwork: Networking.devices.values
        .map(d => d.networks?.values.find(n => n.connected))
        .find(n => n) ?? null

    readonly property bool wifiConnected: activeNetwork !== null
    readonly property string wifiName: activeNetwork?.name ?? ""
    readonly property real wifiStrength: activeNetwork?.signalStrength ?? 0

    readonly property bool online: Networking.devices.values.some(d => d.connected)

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool bluetoothEnabled: adapter?.enabled ?? false

    readonly property int bluetoothDevices: Bluetooth.devices.values.filter(d => d.connected).length
    readonly property bool bluetoothConnected: bluetoothDevices > 0

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled
    }

    function toggleBluetooth() {
        if (adapter)
            adapter.enabled = !adapter.enabled
    }
}

