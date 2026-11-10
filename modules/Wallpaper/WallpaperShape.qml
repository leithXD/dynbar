import QtQuick
import qs.Components
import qs.Core

ClippingShape {
    anchors.fill: parent
    opacity: 0
    morphDuration: 500

    Image {
        source: Shellstate.wallpaper
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

}
