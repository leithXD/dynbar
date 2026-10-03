import QtQuick

Behavior {
    id: root
    property int duration: 300
    property int easing: Easing.OutBack

    NumberAnimation {
        duration: root.duration
        easing.type: root.easing
    }
}
