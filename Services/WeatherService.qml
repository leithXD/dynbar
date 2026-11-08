import QtQuick
import Quickshell
import Quickshell.Io
import qs.Core
pragma Singleton

Singleton {
    id: root

    property string cityName: Config.services.weatherLocation
    property string temperature: "--"
    property string weatherDescription: "Loading..."
    property int weatherCode: 0
    property string weatherIcon
    property string locationName: ""

    function parseWeather(text) {
        try {
            const data = JSON.parse(text);
            if (data && data.current) {
                temperature = Math.round(data.current.temperature_2m) + "°C";
                weatherCode = data.current.weather_code;
                weatherDescription = decodeWeatherCode(weatherCode);
                weatherIcon = decodeWeatherIcon(weatherCode);
            }
        } catch (e) {
            console.log("Error while parsing weather data:", e);
        }
    }

    function parseGeocoding(text) {
        try {
            const data = JSON.parse(text);
            if (data && data.results && data.results.length > 0) {
                const loc = data.results[0];
                locationName = loc.name;
                weatherProc.command = ["sh", "-c", "curl -s 'https://api.open-meteo.com/v1/forecast?latitude=" + loc.latitude + "&longitude=" + loc.longitude + "&current=temperature_2m,weather_code'"];
                weatherProc.running = true;
            } else {
                locationName = "City not found";
                weatherDescription = "Error";
            }
        } catch (e) {
            console.log("Error in Geocoding:", e);
        }
    }

    function decodeWeatherIcon(code) {
        switch (code) {
        case 0:
            return "sunny";
        case 1:
        case 2:
        case 3:
            return "partly_cloudy_day";
        case 45:
        case 48:
            return "foggy";
        case 51:
        case 53:
        case 55:
            return "rainy_light";
        case 61:
        case 63:
        case 65:
            return "rainy";
        case 71:
        case 73:
        case 75:
            return "snowing";
        case 95:
        case 96:
        case 99:
            return "thunderstorm";
        default:
            return "thermostat";
        }
    }

    function decodeWeatherCode(code) {
        switch (code) {
        case 0:
            return "Clear";
        case 1:
        case 2:
        case 3:
            return "Partly Cloudy";
        case 45:
        case 48:
            return "Foggy";
        case 51:
        case 53:
        case 55:
            return "Drizzle";
        case 61:
        case 63:
        case 65:
            return "Rain";
        case 71:
        case 73:
        case 75:
            return "Snowfall";
        case 95:
        case 96:
        case 99:
            return "Thunderstorm";
        default:
            return "Unkown (" + code + ")";
        }
    }

    Process {
        id: geoProc

        command: ["sh", "-c", "curl -s 'https://geocoding-api.open-meteo.com/v1/search?name=" + encodeURIComponent(root.cityName) + "&count=1'"]

        stdout: StdioCollector {
            onStreamFinished: root.parseGeocoding(text)
        }

    }

    Process {
        id: weatherProc

        stdout: StdioCollector {
            onStreamFinished: root.parseWeather(text)
        }

    }

    Timer {
        interval: 900000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!geoProc.running && !weatherProc.running)
                geoProc.running = true;

        }
    }

}
