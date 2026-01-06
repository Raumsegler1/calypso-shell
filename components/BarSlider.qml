import QtQuick
import Quickshell.Widgets
import qs.config

ClippingRectangle {
    id: root

    property real value: 0.5 
    signal moved(real newValue)

    implicitWidth: isVertical ? thickness : dynamicLength
    implicitHeight: isVertical ? dynamicLength : thickness
    Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
    Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }

    property real fillPercent: {
        if (hides) return mouse.hovered ? Math.min(root.value, 1.0) : 1.0
        return root.value
    }

    readonly property real dynamicLength: {
        if (hides) return mouse.hovered ? length : thickness 
        return length
    }

    property alias sliderfgcol: slider.color     // the value itself
    property color sliderfgval: Theme.primary // the color with effects applied

    property alias sliderbgcol: root.color       // the value itself
    property color sliderbgval: Theme.primary // the color with effects applied

    readonly property alias onSlider: mouse.hovered

    property real length:    Theme.widgetwidth * 5
    property real thickness: Theme.widgetwidth
    property real sliderRadius: 0
    property bool isVertical: true
    property bool hides: false
    property bool sliderDirectionRight: true


    color: Qt.darker(root.sliderbgval, 3)
    radius: Theme.smallradius

    Rectangle {
        id: slider
        
        anchors.centerIn: undefined
        
        height: isVertical ? parent.height * root.fillPercent : undefined
        width: isVertical ? undefined : parent.width * root.fillPercent
        
        color: root.sliderfgval
        radius: root.sliderRadius
    }

    states: [
        State {
            name: "VERTICAL"
            when: root.isVertical
            AnchorChanges {
                target: slider
                // Stretch Width (Left+Right), Stick Bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: undefined
            }
            PropertyChanges {
                target: slider
                // Height is dynamic, Width follows anchors
                height: parent.height * root.fillPercent
                width: parent.width // Ignored by anchors, but good for safety
            }
        },
        State {
            name: "HORIZONTAL_LTR" // Grows Left -> Right
            when: !root.isVertical && root.sliderDirectionRight
            AnchorChanges {
                target: slider
                // Stretch Height (Top+Bottom), Stick Left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: undefined // Explicitly break the right anchor
            }
            PropertyChanges {
                target: slider
                // Width is dynamic, Height follows anchors
                width: parent.width * root.fillPercent
                height: parent.height 
            }
        },
        State {
            name: "HORIZONTAL_RTL" // Grows Right -> Left
            when: !root.isVertical && !root.sliderDirectionRight
            AnchorChanges {
                target: slider
                // Stretch Height (Top+Bottom), Stick Right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: undefined // Explicitly break the left anchor
            }
            PropertyChanges {
                target: slider
                width: parent.width * root.fillPercent
                height: parent.height 
            }
        }
    ]

     // --- MOUSE AREA ---
    MouseArea {
        anchors.fill: parent
        function calculateLevel(mouse) {
            var rawPercent = isVertical 
                ? 1.0 - (mouse.y / root.height)
                : mouse.x / root.width
            if (rawPercent < 0) rawPercent = 0
            if (rawPercent > 1) rawPercent = 1
            root.moved(rawPercent)
        }
        onPressed: (mouse) => calculateLevel(mouse)
        onPositionChanged: (mouse) => calculateLevel(mouse)
    }
    
    HoverHandler { id: mouse }   
}