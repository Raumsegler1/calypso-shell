import QtQuick
import qs.config
import qs.services
import qs.components

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
        id: bind
        target: root.bar
        property: {
            if (Theme.barPosition === "right") return "topLeftRadius"
            if (Theme.barPosition === "top") return "bottomLeftRadius"
            if (Theme.barPosition === "bottom") return "topLeftRadius"
            return "topRightRadius"
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
        text: Theme.icon 
    }

    // --- THE MAGIC COMPONENT ---
    PopupHandler {
        id: popup
        
        // 1. Where is the popup file?
        // use Qt.resolvedUrl to ensure it finds the file relative to this one
        popupSource: Qt.resolvedUrl("UserPopup.qml")
    }
}