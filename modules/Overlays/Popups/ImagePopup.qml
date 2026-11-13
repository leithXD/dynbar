import QtQuick
import Quickshell.Widgets
import qs.Components
import qs.Core

ClippingRectangle {
    id: imagePopup

    property string imagePath: ""
    property int screenHeight: 100
    property int index: 0
    property int rotationIndex: (index % 3) + 1

    radius: 20
    rotation: {
        switch (imagePopup.rotationIndex) {
        case 1:
            return -30;
        case 2:
            return 0;
        case 3:
            return 30;
        }
    }
    width: 100
    height: width * (16 / 12)
    color: Colors.surfaceColor
    anchors.horizontalCenter: parent.horizontalCenter
    y: 1080
    Component.onCompleted: {
        y = 1080 - 100 - height;
    }

    Image {
        anchors.fill: parent
        source: imagePath
        fillMode: Image.PreserveAspectCrop
        mipmap: true
    }

    Timer {
        id: delay

        interval: 3000
        running: true
        repeat: false
        onTriggered: imagePopup.destroy()
    }

    Timer {
        id: outAnim

        interval: 2500
        running: true
        repeat: false
        onTriggered: y = 1080
    }

    Spring on y {
    }

}
