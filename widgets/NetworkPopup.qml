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
    baseWidth: background.width + padding
    baseHeight: background.height + padding

    inverseCornerBottom: Theme.isVertical ? Theme.smallradius : 0

    property color textCol: Theme.primary

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: layout.width -padding
        height: layout.height + padding
        radius: Theme.bigradius
        color: Theme.surface_container

        Column {
            id: layout
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: Network.ssid
                color: popup.textCol
                font.pixelSize: Theme.fontsize2
                font.bold: Theme.bold
                anchors.horizontalCenter: parent.horizontalCenter
                width: 155
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }

            // Separator
            Rectangle {
                width: background.width * 0.92
                radius: width/2
                height: 1
                color: Theme.outline_variant
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Speed Display
            Row {
                spacing: 15
                anchors.horizontalCenter: parent.horizontalCenter
                Text { 
                    text: " " + Network.formatDownloadSpeed 
                    color: popup.textCol
                    font.pixelSize: Theme.fontsize2
                }
                Text { 
                    text: " " + Network.formatUploadSpeed 
                    color: popup.textCol
                    font.pixelSize: Theme.fontsize2
                }
            }
        }
    }
}