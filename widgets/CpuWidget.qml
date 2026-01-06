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
        if (Cpu.cpuPercentage > 90) return Theme.tertiary // Highlight when pinned
        if (Cpu.cpuPercentage) return Theme.primary
        return Theme.error
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontsize2
        font.bold: Theme.bold
        color: {
            if (Cpu.cpuPercentage > 90) return Theme.on_tertiary // Highlight when pinned
            if (Cpu.cpuPercentage) return Theme.on_primary
            return Theme.on_error
        }
        text: {
            var s = Cpu.cpuPercentage
            if (s) return s + " "
            return ""
        }
    }
}