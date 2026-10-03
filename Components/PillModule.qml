import QtQuick
import qs.Core

Item {
    id: root
    anchors.fill: parent

    required property string name
    property Component compact
    property Component expanded
    property bool keepCompact: false
    property bool standalone: false

    readonly property bool active: Shellstate.activePill === name
    readonly property bool showExpanded: active && expanded !== null
                                         && (standalone || Shellstate.maximized)
    readonly property bool showCompact: active && compact !== null && !standalone
                                        && (!Shellstate.maximized || keepCompact || expanded === null)

    readonly property real targetWidth:  showExpanded ? expandedLayer.w : compactLayer.w
    readonly property real targetHeight: showExpanded ? expandedLayer.h : compactLayer.h

    component Layer: Loader {
        id: layer
        property bool shown: false
        property real hiddenScale: 1.2
        readonly property real w: item ? item.implicitWidth : 0
        readonly property real h: item ? item.implicitHeight : 0

        anchors.centerIn: parent
        active: shown || opacity > 0
        opacity: shown ? 1 : 0
        scale: shown ? 1 : hiddenScale
        Spring on opacity {}
        Spring on scale {}
    }

    Layer { id: compactLayer;  shown: root.showCompact;  sourceComponent: root.compact }
    Layer { id: expandedLayer; shown: root.showExpanded; sourceComponent: root.expanded; hiddenScale: 0.5 }
}
