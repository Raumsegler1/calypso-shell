import QtQuick
import qs.config
import qs.services
import qs.components

Rectangle {
    id: root

    property var barWindow: null
    
    // --- STYLE ---
    implicitWidth: Theme.widgetwidth
    implicitHeight: Theme.widgetwidth
    radius: Theme.smallradius
    
    color: {
        if (popup.pinned) return Theme.accent // Highlight when pinned
        if (!Network.isConnected) return Theme.error
        if (Network.isWifi) return Theme.foreground
        return Theme.error
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontsize2
        font.bold: Theme.bold
        color: Theme.background
        text: {
            if (!Network.isConnected) return "󰤮"
            if (Network.isEthernet) return "󰈀"
            var s = Network.strength
            if (s > 75) return s + "󰤨"
            if (s > 50) return s + "󰤥"
            if (s > 25) return s + "󰤢"
            if (s > 0) return s + "󰤟"
            return "󰤫"
        }
    }

    // --- THE MAGIC COMPONENT ---
    PopupHandler {
        id: popup
        
        // 1. Where is the popup file?
        // use Qt.resolvedUrl to ensure it finds the file relative to this one
        popupSource: Qt.resolvedUrl("NetworkPopup.qml")
        pinnable: true 
    }
}