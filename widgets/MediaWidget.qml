import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.services
import qs.components

Rectangle {
    id: root

    property int playerPadding: 2

    // --- STYLE ---
    implicitWidth: Theme.widgetwidth 
    implicitHeight: Theme.widgetwidth
    color: Qt.darker(Theme.foreground, 4)

    visible: Media.isConnected ? true : false
    clip: true
    radius: Theme.smallradius
    ClippingRectangle {
        anchors.centerIn: parent
        width: Theme.widgetwidth - playerPadding
        height: Theme.widgetwidth - playerPadding
        radius: 32
        border.width: 1
        border.color: {
            if (popup.pinned) return Theme.accent // Highlight when pinned
            if (!Media.isConnected) return Theme.error
            return Theme.foreground
        }
        Image {
            id: sourceImage
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
            width: Theme.widgetwidth - playerPadding
            height: Theme.widgetwidth - playerPadding
            source: Media.trackArtUrl
            visible: true
            layer.enabled: true
            layer.effect: MultiEffect {
                colorization: Media.isPlaying ? 0 : 1.0 // 1.0
                colorizationColor: Theme.foreground
            }
            transform: Rotation { 
                origin.x: sourceImage.width/2; 
                origin.y: sourceImage.height/2; 
                angle: Media.position*10; 
            }
        }

        Rectangle {
            id: selector
            anchors.centerIn: parent
            implicitWidth: parent.width
            implicitHeight: parent.height
            radius: 32
            color: popup.hovered ? Qt.darker(Theme.foreground, 5) : "transparent"
            opacity: 0.8
        }

        Text {
            id: selectorIcon
            anchors.centerIn: parent
            font.pixelSize: Theme.fontsize1
            font.bold: true
            color: popup.hovered ? Qt.lighter(Theme.foreground, 2) : "transparent"
            opacity: 0.8
            text: Media.isPlaying ? "" : " "  
        }
    }

    // --- THE MAGIC COMPONENT ---
    PopupHandler {
        id: popup
        
        popupSource: Qt.resolvedUrl("MediaPopup.qml")
    }
    
    TapHandler {
        onTapped: {
            Media.player.togglePlaying()
        }
    }
}