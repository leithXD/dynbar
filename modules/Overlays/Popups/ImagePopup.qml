import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Core

ClippingRectangle {
    id: rect

    property string fileType: model.fileType

    width: 100
    height: 140
    anchors.right: parent.right
    anchors.rightMargin: -width - 100
    y: 150
    radius: 20
    opacity: 0
    color: Colors.md3.surface
    Component.onCompleted: {
        anchors.rightMargin = width / 2 + (index * 6);
        opacity = 1;
        let val = index % 3 + 1;
        switch (val) {
        case 2:
            rotation = 30;
            break;
        case 3:
            rotation = -30;
            break;
        }
    }

    Loader {
        active: rect.fileType === "image"
        anchors.fill: parent

        sourceComponent: AnimatedImage {
            source: model.file
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            mipmap: true
        }

    }

    Loader {
        active: rect.fileType !== "image"
        anchors.centerIn: parent

        sourceComponent: ClippingRectangle {
            radius: 15
            width: rect.width / 1.5
            height: rect.height / 1.5
            color: "transparent"
            anchors.centerIn: rect

            Image {
                source: {
                    switch (model.fileType) {
                    case "archive":
                        return Quickshell.iconPath("application-x-archive");
                    case "video":
                        return Quickshell.iconPath("video-x-generic");
                    case "audio":
                        return Quickshell.iconPath("audio-x-generic");
                    case "document":
                        return Quickshell.iconPath("application-pdf");
                    case "unkown":
                        return Quickshell.iconPath("application-octet-stream");
                    default:
                        return Quickshell.iconPath("unkown");
                    }
                }
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                mipmap: true
                scale: 1.2 // dont ask me
            }

        }

    }

    Timer {
        interval: 3000
        repeat: false
        running: true
        onTriggered: {
            anchors.rightMargin = -width;
            rotation = 0;
            opacity = 0;
        }
    }

    Timer {
        interval: 3500
        repeat: false
        running: true
        onTriggered: Shellstate.localsendImages.remove(0)
    }

    SequentialAnimation {
        loops: Animation.Infinite
        running: true

        NumberAnimation {
            target: rect
            property: "y"
            to: 152
            duration: 1000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: rect
            property: "y"
            to: 148
            duration: 1000
            easing.type: Easing.InOutQuad
        }

    }

    Spring on opacity {
        duration: 200
    }

    Spring on anchors.rightMargin {
    }

    Spring on rotation {
        duration: 800
    }

}
