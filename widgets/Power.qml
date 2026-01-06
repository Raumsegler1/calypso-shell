import QtQuick
import qs.config
import qs.services
import qs.components
import Quickshell.Io

Rectangle {
    id: root

    property var barWindow: null
    property Rectangle bar: null
    
    // --- STYLE ---
    implicitWidth: Theme.widgetwidth
    implicitHeight: Theme.widgetwidth
    radius: Theme.smallradius
    
    color: {
        if (popup.pinned) return Theme.tertiary // Highlight when pinned
        return Theme.primary
    }

    property real _currentRadius: ((popup._popupWindow && popup._popupWindow.visible)) ? 0 : Theme.barradius

    // 2. Add Behavior to animate this local property automatically
    Behavior on _currentRadius {
        NumberAnimation {
            duration: popup._popupWindow?.visible ? 800 : 10
            easing.type: Easing.OutExpo
        }
    }

    Binding {
        target: root.bar
        property: {
            if (Theme.barPosition === "left") return "bottomRightRadius"
            if (Theme.barPosition === "right") return "bottomLeftRadius"
            if (Theme.barPosition === "bottom") return "topRightRadius"
            if (Theme.barPosition === "top") return "bottomRightRadius"
        }
        
        // Logic: If hovered, radius is 0. Else, use the theme radius.
        value: _currentRadius
        
        // Only active when bar is set
        when: root.bar !== null
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontsize1
        font.bold: Theme.bold
        color: Theme.on_primary
        text: ""
    }

    // --- THE MAGIC COMPONENT ---
    PopupHandler {
        id: popup
        
        // 1. Where is the popup file?
        // use Qt.resolvedUrl to ensure it finds the file relative to this one
        popupSource: Qt.resolvedUrl("PowerPopup.qml")
    }

    TapHandler {
        onTapped: {
            statusProc.running = truebackground
        }
    }

    Process {
        id: statusProc
        command: ["rofi", "-config", "~/.config/rofi/launcher.rasi", "-show", "drun"]
        running: false
    }
}