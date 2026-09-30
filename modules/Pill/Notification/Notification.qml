import Quickshell
import QtQuick
import qs.Core

Item {
    width: 400
    height: 80
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.leftMargin: 15
    anchors.topMargin: 15
    Column {
        spacing: 8
        Text{
            id: header
            text: "Leith"
            color: Theme.textDark
            font.family: "Rubik"
        }
        Text{
            id: msg
            text: "Hey idk random message"
            color: Theme.text
            font.family: "Rubik"
        }
    }
}
