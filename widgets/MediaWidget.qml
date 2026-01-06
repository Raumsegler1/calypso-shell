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

    // --- COLOR ---
    color: Theme.surface_container
    border.color: Theme.outline_variant
    border.width: Theme.borderwidth

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
            if (popup.pinned) return Theme.tertiary
            if (!Media.isConnected) return Theme.error
            return Media.isPlaying ? Theme.primary : Theme.outline
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
                colorization: Media.isPlaying ? 0 : 0.6
                colorizationColor: Theme.surface
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
            color: Theme.on_surface
            opacity: popup.hovered ? 0.12 : 0

            // Interaction: Fade in/out smoothly
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }

        Text {
            id: selectorIcon
            anchors.centerIn: parent
            font.pixelSize: Theme.fontsize1
            font.bold: true
            color: Theme.on_surface
            opacity: popup.hovered ? 1.0 : 0.0
            text: Media.isPlaying ? "" : " "

            // Interaction: Fade in/out smoothly
            Behavior on opacity { NumberAnimation { duration: 150 } }  
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