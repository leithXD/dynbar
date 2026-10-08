pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import qs.Core
import QtQuick

Singleton {
    id: root
    property bool usesBattery: UPower.onBattery
}
