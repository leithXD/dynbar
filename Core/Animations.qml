import QtQuick
import Quickshell
pragma Singleton

Singleton {

    component Anim: QtObject {
        readonly property int short1: 50
        readonly property int short2: 100
        readonly property int short3: 150
        readonly property int short4: 200

        readonly property int medium1: 250
        readonly property int medium2: 300
        readonly property int medium3: 350
        readonly property int medium4: 400
        readonly property int long1: 450
        readonly property int long2: 500
        readonly property int long3: 550
        readonly property int long4: 600

        readonly property list<real> standard:        [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardDecel:        [0, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel:        [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> emphasized: [0.05, 0.0, 0.133333, 0.06, 0.166666, 0.4, 0.208333, 0.82, 0.25, 1.0, 1.0,1.0]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> smooth: [0.25, 0.1, 0.25, 1]
        readonly property list<real> spring: [0.38, 1.21, 0.22, 1, 1, 1]
    }
    readonly property Anim anim: Anim {}
}

