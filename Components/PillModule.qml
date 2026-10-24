import QtQuick
import qs.Core

Item {
    id: root

    required property var pill
    required property string name
    property Component compact
    property Component expanded
    property bool keepCompact: false
    property bool standalone: false
    readonly property bool active: pill.activePill === name
    readonly property bool showExpanded: active && expanded !== null && (standalone || pill.maximized)
    readonly property bool showCompact: active && compact !== null && !standalone && (!pill.maximized || keepCompact || expanded === null)
    readonly property real targetWidth: showExpanded ? expandedLayer.w : compactLayer.w
    readonly property real targetHeight: showExpanded ? expandedLayer.h : compactLayer.h

    anchors.fill: parent

    Layer {
        id: compactLayer

        shown: root.showCompact
        sourceComponent: root.compact
    }

    Layer {
        id: expandedLayer

        shown: root.showExpanded
        sourceComponent: root.expanded
        hiddenScale: 0.5
    }

    component Layer: Loader {
        id: layer

        property bool shown: false
        property real hiddenScale: 1.5
        readonly property real w: item ? item.implicitWidth : 0
        readonly property real h: item ? item.implicitHeight : 0
        readonly property bool isLauncher: pill.activePill === "launcher"

        anchors.centerIn: parent
        active: shown || opacity > 0
        opacity: shown ? 1 : 0
        scale: shown ? 1 : hiddenScale

        Spring on opacity {
            duration: pill.outLauncher ? 400 : 200
        }

        Spring on scale {
        }

    }

}
