import QtQuick
import qs.Core

Loader {
    id: barSettings

    required property int page
    required property int index
    property bool wanted: page === index

    anchors.fill: parent
    active: opacity > 0
    anchors.topMargin: wanted ? 0 : 30
    opacity: wanted ? 1 : 0
    scale: wanted ? 1 : 0.95

    Anim on anchors.topMargin {
    }

    Anim on scale {
    }

    Anim on opacity {
        state: ""
        curve: Animations.anim.smooth
        duration: Animations.anim.short4
    }

}
