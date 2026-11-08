import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Components
import qs.Core
import qs.Services

Item {
    anchors.fill: parent

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    RowLayout {
        anchors.fill: parent

        MaterialIcon {
            name: WeatherService.weatherIcon
            Layout.preferredWidth: 80
            size: 44
            color: Colors.md3.on_surface
        }

        Text {
            text: WeatherService.temperature
            font: Typography.displayMedium
            color: Colors.md3.primary
        }

    }

    Text {
        text: WeatherService.cityName
        font: Typography.bodySmall
        color: Colors.md3.inverse_on_surface
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        opacity: 0.5
    }

}
