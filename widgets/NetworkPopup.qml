import QtQuick
import QtQuick.Layouts
import Quickshell     
import Quickshell.Io
import qs.config
import qs.components
import qs.services

SidebarPopup {
    id: popup
    property real padding: 20
    baseWidth: 115 + padding
    baseHeight: layout.height + padding

    Column {
        id: layout
        anchors.centerIn: parent

        Text {
            text: "Network"
            color: Theme.accent
            font.bold: true
            font.pixelSize: Theme.fontsize2
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Network.ssid
            color: Theme.foreground
            font.pixelSize: Theme.fontsize2
            anchors.horizontalCenter: parent.horizontalCenter
            // Limit width so long SSIDs don't break layout
            width: popup.width - 20
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }

        // Separator
        Rectangle {
            width: parent.width * 0.8
            height: 2
            color: "transparent" //Theme.accent
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Speed Display
        Row {
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter
            Text { 
                text: " " + Network.formatDownloadSpeed 
                color: Theme.foreground 
                font.pixelSize: Theme.fontsize2
            }
            Text { 
                text: " " + Network.formatUploadSpeed 
                color: Theme.foreground 
                font.pixelSize: Theme.fontsize2
            }
        }
    }
}