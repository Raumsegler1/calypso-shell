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
    baseWidth: (Theme.isVertical ? 300:400) + padding
    baseHeight: (Theme.isVertical ? 400:300) + padding
    //baseWidth: (child.width) + padding
    //baseHeight: (child.height) + padding
    anchor.margins.bottom: + Theme.widgetwidth + Theme.widgetmargin*2 - popup.height
    inverseCornerTop: 0

    property color hoveredButton: Theme.background
    property color surfaceButton: Qt.darker(Theme.foreground, 4)
    property color onButton: Theme.foreground 
    // ""
    // ""
    

    Item {
        id: positionHandler
        // --- STATES (Moved INSIDE Item so they work) ---
        state: {
            if (Theme.barPosition === "right") return "RIGHT"
            if (Theme.barPosition === "top") return "TOP"
            if (Theme.barPosition === "bottom") return "BOTTOM"
            return "LEFT"
        }

        states: [
            State {
                name: "LEFT"
                // Bar is on Left -> Popup on Right
                PropertyChanges { 
                    target: popup
                    inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: - popup.height + Theme.widgetwidth + Theme.widgetmargin*2
                }
            },
            State {
                name: "RIGHT"
                // Bar is on Right -> Popup on Left
                PropertyChanges { 
                    target: popup
                    inverseCornerBottom: 0
                    //anchor.gravity: Edges.Left | Edges.Top
                    edgeAdjust1: - popup.height + Theme.widgetwidth + Theme.widgetmargin*2
                }
            },
            State {
                name: "TOP"
                // Bar is Top -> Popup on Bottom
                PropertyChanges { 
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: - popup.width + Theme.widgetwidth + Theme.widgetmargin*2
                }
            },
            State {
                name: "BOTTOM"
                // Bar is Bottom -> Popup on Top
                PropertyChanges { 
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: - popup.width + Theme.widgetwidth + Theme.widgetmargin*2
                }
            }
        ]
    }
}