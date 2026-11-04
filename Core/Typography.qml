import QtQuick
pragma Singleton

QtObject {
    readonly property string fontFamily: "Google Sans Flex"
    readonly property font displayLarge: Qt.font({
        "family": fontFamily,
        "pixelSize": 57,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 57
        }
    })
    readonly property font displayMedium: Qt.font({
        "family": fontFamily,
        "pixelSize": 45,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 45
        }
    })
    readonly property font displaySmall: Qt.font({
        "family": fontFamily,
        "pixelSize": 36,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 36
        }
    })
    readonly property font headlineLarge: Qt.font({
        "family": fontFamily,
        "pixelSize": 32,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 32
        }
    })
    readonly property font headlineMedium: Qt.font({
        "family": fontFamily,
        "pixelSize": 28,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 28
        }
    })
    readonly property font headlineSmall: Qt.font({
        "family": fontFamily,
        "pixelSize": 24,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 24
        }
    })
    readonly property font titleLarge: Qt.font({
        "family": fontFamily,
        "pixelSize": 22,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 22
        }
    })
    readonly property font titleMedium: Qt.font({
        "family": fontFamily,
        "pixelSize": 16,
        "weight": Font.Medium,
        "variableAxes": {
            "wght": 500,
            "opsz": 16
        }
    })
    readonly property font titleSmall: Qt.font({
        "family": fontFamily,
        "pixelSize": 14,
        "weight": Font.Medium,
        "variableAxes": {
            "wght": 500,
            "opsz": 14
        }
    })
    readonly property font bodyLarge: Qt.font({
        "family": fontFamily,
        "pixelSize": 16,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 16
        }
    })
    readonly property font bodyMedium: Qt.font({
        "family": fontFamily,
        "pixelSize": 14,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 14
        }
    })
    readonly property font bodySmall: Qt.font({
        "family": fontFamily,
        "pixelSize": 12,
        "weight": Font.Normal,
        "variableAxes": {
            "wght": 400,
            "opsz": 12
        }
    })
    readonly property font labelLarge: Qt.font({
        "family": fontFamily,
        "pixelSize": 14,
        "weight": Font.Medium,
        "variableAxes": {
            "wght": 500,
            "opsz": 14
        }
    })
    readonly property font labelMedium: Qt.font({
        "family": fontFamily,
        "pixelSize": 12,
        "weight": Font.Medium,
        "variableAxes": {
            "wght": 500,
            "opsz": 12
        }
    })
    readonly property font labelSmall: Qt.font({
        "family": fontFamily,
        "pixelSize": 11,
        "weight": Font.Medium,
        "variableAxes": {
            "wght": 500,
            "opsz": 11
        }
    })
}
