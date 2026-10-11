import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.Core
pragma Singleton

Singleton {
    id: root

    property bool usesBattery: UPower.onBattery
}
