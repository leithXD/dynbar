import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.Core
pragma Singleton

Singleton {
    id: root

    property bool usesBattery: UPower.onBattery
    property real percentage: UPower.displayDevice ? UPower.displayDevice.percentage * 100 : 0
    property int state: UPower.displayDevice ? UPower.displayDevice.state : UPowerDeviceState.Unknown
    property bool criticalPercentage: percentage < 15

    onUsesBatteryChanged: {
        if (usesBattery)
            Shellstate.createToast("Battery", "I am running on battery now!", "charger");
        else
            Shellstate.createToast("Battery", "Thanks for plugging me in <3.", "power");
    }
}
