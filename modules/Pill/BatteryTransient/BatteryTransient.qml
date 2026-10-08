import QtQuick
import qs.Core
import qs.Services

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 60
    Text {
        anchors.centerIn: parent
        text: BatteryService.usesBattery ? "Discharging" : "Charging"
        color: Theme.text
    }
}
