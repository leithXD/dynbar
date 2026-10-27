import M3Shapes
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Core

WlSessionLockSurface {
    id: surface

    required property string screenCopy
    property bool bgReady: bg.status === Image.Ready
    property string buffer
    required property LockContext context

    signal unlockRequested()
    signal unlock()

    onBufferChanged: {
        context.currentText = buffer;
    }
    color: "black"

    Image {
        id: bg

        anchors.fill: parent
        cache: false
        fillMode: Image.PreserveAspectCrop
        source: surface.screenCopy
        visible: surface.bgReady
    }

    MultiEffect {
        anchors.fill: bg
        source: bg
        blurEnabled: true
        blur: surface.bgReady ? 1 : 0
        blurMax: 64
        blurMultiplier: 1
        autoPaddingEnabled: false

        Behavior on blur {
            NumberAnimation {
                duration: 600
                easing.type: Easing.OutCubic
            }

        }

    }

    ClippingRectangle {
        id: mainCard

        color: Colors.transparency(Colors.md3.surface, 0.8)
        x: (1920 - width) / 2
        y: (1080 - height) / 2
        opacity: surface.bgReady ? 1 : 0
        scale: surface.bgReady ? 1 : 0.2
        width: 1000
        height: 580
        radius: 40

        Timer {
            id: endAnim

            interval: 600
            running: surface.bgReady
            onTriggered: mainCard.width = 1200
        }

        RowLayout {
            id: lockLayout

            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: leftRect

                Layout.preferredWidth: 470
                Layout.fillHeight: true
                radius: 30
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0)

                ClippingRectangle {
                    // MaterialShape {
                    //    id: shape
                    //  width: img.width
                    //  height: img.height
                    //  shape: MaterialShape.Cookie6Sided
                    //  color: Colors.md3.primary
                    //  layer.enabled: true
                    // layer.smooth: true
                    // }
                    // MultiEffect {
                    //  anchors.fill: img
                    //  source: img
                    //  maskEnabled: true
                    //  maskSource: shape
                    // } looks janky i need smth else

                    id: avatar

                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 70
                    width: img.width
                    height: img.height
                    radius: width / 2
                    color: "transparent"

                    Image {
                        id: img

                        anchors.centerIn: parent
                        source: Shellstate.avatar
                        width: 230
                        height: 230
                        fillMode: Image.PreserveAspectCrop
                        antialiasing: true
                        mipmap: true
                        // sourceSize: Qt.size(192, 192)
                        opacity: 0.8
                        smooth: true
                    }

                }

                SequentialAnimation {
                    id: shakeRotation

                    running: context.showFailure

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: -6
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: 6
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: -4
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: 4
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: -2
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: 2
                        duration: 50
                    }

                    NumberAnimation {
                        target: passwdContainer
                        property: "rotation"
                        to: 0
                        duration: 50
                    }

                }

                ClippingRectangle {
                    id: passwdContainer

                    width: surface.buffer === "" ? 150 : 300
                    height: 40
                    radius: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 80
                    focus: true
                    color: Colors.transparency(Colors.md3.inverse_on_surface, 0.8)
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return) {
                            console.log("Enter");
                            context.tryUnlock();
                            surface.buffer = "";
                            event.accepted = true;
                            return ;
                        }
                        if (event.key === Qt.Key_Escape) {
                            surface.onUnlock();
                            event.accepted = true;
                            return ;
                        }
                        if (event.key === Qt.Key_Backspace) {
                            if (surface.buffer.length > 0) {
                                surface.buffer = surface.buffer.slice(0, -1);
                                event.accepted = true;
                                return ;
                            }
                        }
                        surface.buffer += event.text;
                        event.accepted = true;
                    }

                    MaterialIcon {
                        name: "lock"
                        anchors.centerIn: parent
                        color: Colors.md3.surface_variant
                        opacity: surface.buffer === "" ? 1 : 0
                        visible: opacity > 0.1

                        Smooth on opacity {
                        }

                    }

                    ListView {
                        id: passwordChars

                        property var shapes: [MaterialShape.Square, MaterialShape.SemiCircle, MaterialShape.Oval, MaterialShape.Pill, MaterialShape.Triangle, MaterialShape.Diamond, MaterialShape.Pentagon, MaterialShape.Gem, MaterialShape.Sunny, MaterialShape.VerySunny, MaterialShape.Cookie4Sided, MaterialShape.Cookie6Sided, MaterialShape.Clover4Leaf, MaterialShape.SoftBurst, MaterialShape.Flower, MaterialShape.Puffy]
                        property int currentShape: 0

                        spacing: 3
                        clip: true
                        width: parent.width - 80
                        height: 20
                        orientation: ListView.Horizontal
                        anchors.centerIn: parent
                        highlightMoveDuration: 100
                        onContentWidthChanged: {
                            if (contentWidth > width) {
                                contentXAnim.to = contentWidth - width;
                                contentXAnim.restart();
                            }
                        }

                        NumberAnimation {
                            id: contentXAnim

                            target: passwordChars
                            property: "contentX"
                            duration: 200
                            easing.type: Easing.OutCubic
                        }

                        model: ScriptModel {
                            values: surface.buffer.split("")
                        }

                        delegate: MaterialShape {
                            id: character

                            shape: passwordChars.shapes[index % passwordChars.shapes.length]
                            width: 20
                            height: 20
                            color: Colors.md3.on_surface
                            animationDuration: 600
                            animationEasing.type: Easing.InOutCubic
                            Component.onCompleted: {
                                if (passwordChars.currentShape === passwordChars.shapes.length)
                                    passwordChars.currentShape = 0 && console.log("currentShape reset");
                                else
                                    passwordChars.currentShape++ && console.log("currentShape +1");
                                animTimer.running = true;
                            }

                            Timer {
                                id: animTimer

                                interval: 50
                                running: false
                                onTriggered: character.shape = MaterialShape.Circle
                            }

                        }

                        add: Transition {
                            NumberAnimation {
                                property: "scale"
                                from: 0.1
                                to: 0.9
                                duration: 500
                                easing.type: Easing.OutBack
                            }

                            NumberAnimation {
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: 300
                                easing.type: Easing.InOutCubic
                            }

                            NumberAnimation {
                                property: "x"
                                from: surface.buffer.length * 20 - 40
                                to: x
                                duration: 300
                                easing.type: Easing.OutCubic
                            }

                        }

                        remove: Transition {
                            NumberAnimation {
                                property: "scale"
                                from: 1
                                to: 0.2
                                duration: 100
                                easing.type: Easing.InCubic
                            }

                            NumberAnimation {
                                property: "opacity"
                                from: 1
                                to: 0
                                duration: 100
                                easing.type: Easing.InCubic
                            }

                        }

                    }

                    Spring on width {
                    }

                }

            }

            Rectangle {
                id: rightRect

                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 30
                color: Colors.transparency(Colors.md3.inverse_on_surface, 0.5)
            }

        }

        Spring on scale {
            duration: 600
        }

        Spring on width {
        }

        Smooth on opacity {
        }

    }

    Rectangle {
        id: button

        width: 180
        height: 56
        radius: height / 2
        color: area.containsMouse ? Qt.lighter(Colors.md3.primary, 1.2) : Colors.md3.primary
        scale: area.pressed ? 0.95 : 1

        Text {
            anchors.centerIn: parent
            text: "Entsperren"
            color: Colors.md3.on_primary
            font.family: "Rubik"
            font.pixelSize: 16
            font.weight: Font.DemiBold
        }

        MouseArea {
            id: area

            anchors.fill: parent
            hoverEnabled: true
            onClicked: surface.unlockRequested()
        }

        Connections {
            function onUnlocked() {
                surface.unlock();
            }

            target: context
        }

        Behavior on color {
            ColorAnimation {
                duration: 150
            }

        }

        Behavior on scale {
            NumberAnimation {
                duration: 120
            }

        }

    }

}
