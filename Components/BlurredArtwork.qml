import QtQuick
import QtQuick.Effects
import qs.Services

Item {
    id: root

    property string source: MediaplayerService.trackArtUrl
    property int blurMax: 32

    anchors.fill: parent

    Image {
        id: bgArt

        anchors.fill: parent
        width: root.implicitWidth
        source: root.source
        fillMode: Image.PreserveAspectCrop
        sourceSize: Qt.size(128, 128)
        visible: false
    }

    MultiEffect {
        anchors.fill: bgArt
        source: bgArt
        blurEnabled: true
        blur: 1
        blurMax: root.blurMax
        blurMultiplier: 1
        autoPaddingEnabled: false
        opacity: bgArt.status === Image.Ready ? 0.4 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 400
            }

        }

    }

}
