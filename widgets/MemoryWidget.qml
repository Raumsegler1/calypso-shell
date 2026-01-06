import QtQuick
import qs.config
import qs.services
import qs.components

Rectangle {
    id: root

    //property var barWindow: null
    
    // --- STYLE ---
    implicitWidth: Theme.widgetwidth
    implicitHeight: Theme.widgetwidth
    radius: Theme.smallradius
    
    color: {
        if (Memory.usedRamRelative > 0.9) return Theme.accent // Highlight when pinned
        if (Memory.usedRamPercentage) return Theme.accent2
        return Theme.error
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontsize2
        font.bold: Theme.bold
        color: Theme.background
        text: {
            var s = Memory.usedRamPercentage
            if (s) return s + " "
            return ""
        }
    }
}