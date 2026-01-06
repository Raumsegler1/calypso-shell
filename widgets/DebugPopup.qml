import QtQuick
import Quickshell
import qs.components
import qs.config

SidebarPopup {
    height: 0
    width: 10
    color: "white"
    backgroundCol: "red"

    inverseCornerTop:0
    inverseCornerBottom:0
    
    property bool pos: false
    Timer {
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            pos = !pos
        }
    }
}


