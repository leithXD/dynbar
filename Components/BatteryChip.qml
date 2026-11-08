import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets
import qs.Components
import qs.Core
import qs.Services

Item {
    id: root

    implicitWidth: rect.width
    implicitHeight: 30

    ClippingRectangle {
        id: rect

        property bool criticalBattery: BatteryService.criticalPercentage
        property bool charging: BatteryService.state === 1

        anchors.centerIn: parent
        width: 70
        height: 30
        radius: 15
        color: criticalBattery ? Colors.layer(Colors.md3.error_container, 2) : Colors.layer(Colors.md3.primary_container, 2)

        Rectangle {
            anchors.left: parent.left
            height: rect.height
            width: rect.width / 100 * BatteryService.percentage
            color: rect.criticalBattery ? Colors.md3.error : Colors.md3.primary

            Behavior on color {
                ColorAnimation {
                    duration: 300
                    easing.type: Easing.InOutCubic
                }

            }

            Spring on width {
            }

        }

        Behavior on color {
            ColorAnimation {
                duration: 300
                easing.type: Easing.InOutCubic
            }

        }

    }

}
