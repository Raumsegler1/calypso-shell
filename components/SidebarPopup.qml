import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.components

PopupWindow {
    id: root

    // --- CONFIGURATION ---
    property bool isHovered: mouseHandler.hovered
    property real cornerRadius: Theme.bigradius
    property color backgroundCol: Theme.surface
    property real heightPadding: 10
    property bool pinned: false
    
    // Use your logic for the inverse corners
    property real inverseCornerTop: Math.min(Theme.bigradius, 11)
    property real inverseCornerBottom: Math.min(Theme.bigradius, 11)
    property real edgeAdjust1: 0
    property real edgeAdjust2: 0
    property real baseHeight: contentContainer.childrenRect.height + heightPadding
    property real baseWidth: 160

    default property alias content: contentContainer.data

    anchor.adjustment: PopupAdjustment.None
    
    // --- YOUR PRESERVED LOGIC ---
    property real startx: {
        if (Theme.barPosition === "left") return -implicitWidth * 1.25
        if (Theme.barPosition === "right") return implicitWidth * 1.25
        return 0
    }
    property real starty: {
        if (Theme.barPosition === "top") return -implicitHeight * 1.25
        if (Theme.barPosition === "bottom") return implicitHeight * 1.25
        return 0
    }

    // Dynamic Size (Adjusted only to ensure space for sticky corners)
    implicitWidth: {
        // If Top/Bottom, we need extra width for the side corners
        if (Theme.barPosition === "top" || Theme.barPosition === "bottom") 
            return baseWidth + (inverseCornerTop + inverseCornerBottom)
        return baseWidth
    }
    implicitHeight: {
        // If Left/Right, we need extra height for the vertical corners
        if (Theme.barPosition === "left" || Theme.barPosition === "right") 
            return baseHeight + (inverseCornerTop + inverseCornerBottom)
        return baseHeight
    }

    color: "transparent"
    visible: false 

    // --- ANIMATION CONTAINER (States go HERE) ---
    Item {
        id: animRoot
        anchors.fill: parent
        opacity: 0
        transform: Translate { id: trans; x: root.startx; y: root.starty }

        // --- BACKGROUND ---
        Rectangle {
            id: bg
            anchors.fill: parent
            
            // Default Margins (Will be overridden by States)
            anchors.topMargin: root.inverseCornerTop
            anchors.bottomMargin: root.inverseCornerBottom
            
            color: root.backgroundCol
            radius: root.cornerRadius
            
            // Default Radius (Will be overridden by States)
            topLeftRadius: 0
            bottomLeftRadius: 0
            
            Item {
                id: contentContainer
                anchors.centerIn: parent
                width: parent.width
            }

            HoverHandler { id: mouseHandler }
        }
        
        // --- STICKY CORNERS ---
        RoundCorner {
            id: c1
            visible: true
            implicitSize: root.inverseCornerTop
            color: root.backgroundCol
        }
        RoundCorner {
            id: c2
            visible: true
            implicitSize: root.inverseCornerBottom
            color: root.backgroundCol
        }

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
                    target: root
                    anchor.edges: Edges.Left
                    anchor.gravity: Edges.Right
                    // Push away from bar
                    anchor.margins.left: Theme.widgetwidth + Theme.widgetmargin 
                    // Pull back slightly (Symmetry with your logic)
                    anchor.margins.right: -Theme.widgetmargin 
                    anchor.margins.bottom: edgeAdjust1
                    anchor.margins.top: edgeAdjust2
                }
                
                // Visuals (Left Flat)
                PropertyChanges { target: bg; anchors.topMargin: root.inverseCornerTop; anchors.bottomMargin: root.inverseCornerBottom; anchors.leftMargin: 0; anchors.rightMargin: 0 }
                PropertyChanges { target: bg; topLeftRadius: 0; bottomLeftRadius: 0; topRightRadius: root.cornerRadius; bottomRightRadius: root.cornerRadius }
                PropertyChanges { target: c1; corner: RoundCorner.CornerEnum.BottomLeft }
                AnchorChanges { target: c1; anchors.bottom: bg.top; anchors.left: bg.left }
                PropertyChanges { target: c2; corner: RoundCorner.CornerEnum.TopLeft }
                AnchorChanges { target: c2; anchors.top: bg.bottom; anchors.left: bg.left }
            },
            State {
                name: "RIGHT"
                // Bar is on Right -> Popup on Left
                PropertyChanges { 
                    target: root
                    anchor.edges: Edges.Right
                    anchor.gravity: Edges.Left
                    // Push away from bar
                    anchor.margins.right: +Theme.widgetwidth + Theme.widgetmargin
                    // RESTORED: Your negative margin
                    anchor.margins.left: -1 -Theme.widgetmargin
                    anchor.margins.bottom: edgeAdjust1
                    anchor.margins.top: edgeAdjust2
                }

                // Visuals (Right Flat)
                PropertyChanges { target: bg; anchors.topMargin: root.inverseCornerTop; anchors.bottomMargin: root.inverseCornerBottom; anchors.leftMargin: 0; anchors.rightMargin: 0 }
                PropertyChanges { target: bg; topLeftRadius: root.cornerRadius; bottomLeftRadius: root.cornerRadius; topRightRadius: 0; bottomRightRadius: 0 }
                PropertyChanges { target: c1; corner: RoundCorner.CornerEnum.BottomRight }
                AnchorChanges { target: c1; anchors.bottom: bg.top; anchors.right: bg.right }
                PropertyChanges { target: c2; corner: RoundCorner.CornerEnum.TopRight }
                AnchorChanges { target: c2; anchors.top: bg.bottom; anchors.right: bg.right }
            },
            State {
                name: "TOP"
                // Bar is Top -> Popup on Bottom
                PropertyChanges { 
                    target: root
                    anchor.edges: Edges.Top
                    anchor.gravity: Edges.Bottom
                    anchor.margins.top: Theme.widgetwidth + Theme.widgetmargin
                    // Symmetrical negative margin
                    anchor.margins.bottom: -Theme.widgetmargin 
                    anchor.margins.right: edgeAdjust1
                    anchor.margins.left: edgeAdjust2
                }

                // Visuals (Top Flat)
                PropertyChanges { target: bg; anchors.leftMargin: root.inverseCornerTop; anchors.rightMargin: root.inverseCornerBottom; anchors.topMargin: 0; anchors.bottomMargin: 0 }
                PropertyChanges { target: bg; topLeftRadius: 0; bottomLeftRadius: root.cornerRadius; topRightRadius: 0; bottomRightRadius: root.cornerRadius }
                PropertyChanges { target: c1; corner: RoundCorner.CornerEnum.TopRight }
                AnchorChanges { target: c1; anchors.right: bg.left; anchors.top: bg.top }
                PropertyChanges { target: c2; corner: RoundCorner.CornerEnum.TopLeft }
                AnchorChanges { target: c2; anchors.left: bg.right; anchors.top: bg.top }
            },
            State {
                name: "BOTTOM"
                // Bar is Bottom -> Popup on Top
                PropertyChanges { 
                    target: root
                    anchor.edges: Edges.Bottom
                    anchor.gravity: Edges.Top
                    anchor.margins.bottom: Theme.widgetwidth + Theme.widgetmargin
                    // Symmetrical negative margin
                    anchor.margins.top: -1 -Theme.widgetmargin 
                    anchor.margins.right: edgeAdjust1
                    anchor.margins.left: edgeAdjust2
                }

                // Visuals (Bottom Flat)
                PropertyChanges { target: bg; anchors.leftMargin: root.inverseCornerTop; anchors.rightMargin: root.inverseCornerBottom; anchors.topMargin: 0; anchors.bottomMargin: 0 }
                PropertyChanges { target: bg; topLeftRadius: root.cornerRadius; bottomLeftRadius: 0; topRightRadius: root.cornerRadius; bottomRightRadius: 0 }
                PropertyChanges { target: c1; corner: RoundCorner.CornerEnum.BottomRight }
                AnchorChanges { target: c1; anchors.right: bg.left; anchors.bottom: bg.bottom }
                PropertyChanges { target: c2; corner: RoundCorner.CornerEnum.BottomLeft }
                AnchorChanges { target: c2; anchors.left: bg.right; anchors.bottom: bg.bottom }
            }
        ]
    }

    // --- ANIMATIONS ---
    onVisibleChanged: {
        if (visible) {
            animRoot.opacity = 1
            trans.x = startx
            trans.y = starty
            enterAnim.restart()
        }
    }

    ParallelAnimation {
        id: enterAnim
        NumberAnimation { target: trans; property: "x"; to: 0; duration: 250; easing.type: Easing.OutExpo }
        NumberAnimation { target: trans; property: "y"; to: 0; duration: 250; easing.type: Easing.OutExpo }
    }
    
    function closeAnimated() {
        exitAnim.restart()
    }
    
    ParallelAnimation {
        id: exitAnim
        onFinished: root.visible = false 
        NumberAnimation { target: trans; property: "x"; to: startx; duration: 250; easing.type: Easing.InQuad }
        NumberAnimation { target: trans; property: "y"; to: starty; duration: 250; easing.type: Easing.InQuad }
    }
}