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
        if (Cpu.cpuPercentage > 90) return Theme.accent // Highlight when pinned
        if (Cpu.cpuPercentage) return Theme.foreground
        return Theme.error
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontsize2
        font.bold: Theme.bold
        color: Theme.background
        text: {
            var s = Cpu.cpuPercentage
            if (s) return s + " "
            return ""
        }
    }
}