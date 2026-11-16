import QtQuick

Behavior {
    id: root

    property string state: "spring"
    property int duration: Animations.anim.medium4
    property var curve: Animations.anim.emphasizedDecel
    property StateGroup _states

    NumberAnimation {
        duration: root.duration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: root.curve
    }

    _states: StateGroup {
        state: root.state
        states: [
            State {
                name: "emphasized"

                PropertyChanges {
                    root.duration: Animations.anim.long2
                    root.curve: Animations.anim.emphasized
                }

            },
            State {
                name: "emphasizedAccel"

                PropertyChanges {
                    root.duration: Animations.anim.short4
                    root.curve: Animations.anim.emphasizedAccel
                }

            },
            State {
                name: "emphasizedDecel"

                PropertyChanges {
                    root.duration: Animations.anim.medium4
                    root.curve: Animations.anim.emphasizedDecel
                }

            },
            State {
                name: "standard"

                PropertyChanges {
                    root.duration: Animations.anim.medium2
                    root.curve: Animations.anim.standard
                }

            },
            State {
                name: "standardAccel"

                PropertyChanges {
                    root.duration: Animations.anim.short4
                    root.curve: Animations.anim.standardAccel
                }

            },
            State {
                name: "standardDecel"

                PropertyChanges {
                    root.duration: Animations.anim.medium1
                    root.curve: Animations.anim.standardDecel
                }

            },
            State {
                name: "spring"

                PropertyChanges {
                    root.duration: Animations.anim.medium4
                    root.curve: Animations.anim.spring
                }

            },
            State {
                name: "smooth"

                PropertyChanges {
                    root.duration: Animations.anim.smooth
                    root.curve: Animations.anim.long1
                }

            }
        ]
    }

}
