import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.components


Rectangle {
    id: root

    property var barWindow: null
    implicitHeight: Theme.isVertical ? Theme.widgetwidth * 2 : Theme.widgetwidth
    implicitWidth: Theme.isVertical ? Theme.widgetwidth : Theme.widgetwidth * 2

    color: Theme.foreground
    radius: Theme.smallradius
    Text {
        id: timeDisplay
        anchors.centerIn: parent
        wrapMode: Text.WrapAnywhere
        text: Theme.isVertical ? Qt.formatTime(new Date(), "hh\nmm") : Qt.formatTime(new Date(), "hh:mm")
        color: Theme.background
        font.pixelSize: Theme.fontsize1
        font.bold: Theme.bold

        Timer {
            id: timer
            running: true
            interval: 1000
            repeat: true
            onTriggered: {
                timeDisplay.text = Theme.isVertical ? Qt.formatTime(new Date(), "hh\nmm") : Qt.formatTime(new Date(), "hh:mm")
                //console.log(popup.implicitHeight)
            }
        }

    }
    PopupHandler {
        id: popup
        
        // 1. Where is the popup file?
        // use Qt.resolvedUrl to ensure it finds the file relative to this one
        popupSource: Qt.resolvedUrl("CalendarPopup.qml") 
        pinnable: true      
    }
}