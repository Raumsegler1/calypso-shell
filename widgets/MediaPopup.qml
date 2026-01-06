import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.components
import qs.services

SidebarPopup {
    id: popup
    property int popupWidth: 200
    property real padding: Theme.widgetmargin*3
    heightPadding: padding
    baseWidth: popupWidth + padding
    baseHeight: content.height + padding
    cornerRadius: Math.min(16, Theme.smallradius)
    Column {
        id: content
        anchors.centerIn: parent
        spacing: Theme.widgetmargin

        ClippingRectangle {
            width: popupWidth 
            height: popupWidth
            radius: Theme.smallradius
            Image {
                id: coverArt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 20
                fillMode: Image.PreserveAspectCrop
                width: popupWidth 
                height: popupWidth
                source: Media.player?.trackArtUrl
                layer.enabled: true
                layer.live: true
                layer.effect: MultiEffect {
                    saturation: 0
                    colorization: Media.isPlaying ? 0 : 1.0
                    colorizationColor: Theme.foreground
                }
                Rectangle {
                    id: pin
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 6
                    implicitWidth: dimension
                    implicitHeight: dimension
                    property var dimension: Theme.widgetwidth
                    color: "transparent"
                    Rectangle {
                        id: selector
                        anchors.centerIn: parent
                        implicitWidth: pin.dimension
                        implicitHeight: pin.dimension
                        radius: Theme.smallradius
                        color: Qt.darker(Theme.foreground, 2)
                        opacity: pinMouse.hovered ? 0.9 : 0.6
                    }

                    Text {
                        id: selectorIcon
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontsize1
                        font.bold: true
                        color: Qt.lighter(Theme.foreground, 2)
                        opacity: (pinMouse.hovered || popup.pinned) ? 1 : 0.4
                        text: popup.pinned ? " " : ""  
                    }

                    HoverHandler { id: pinMouse}
                    TapHandler {
                        onTapped: {
                            popup.pinned = !popup.pinned
                            //console.log(popup.pinned)
                        }
                    }
                }
            } 
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            width: popupWidth 
            height: 40
            color: Qt.darker(Theme.foreground, 4)
            radius: Theme.bigradius
            clip: true
            Rectangle {
                id: title
                clip: true
                anchors {left: parent.left; right: parent.right; top: parent.top; bottom: parent.bottom}
                anchors.margins: 7
                color: "transparent"
                Text {
                    id: titleText
                    font.pixelSize: Theme.fontsize2
                    font.bold: Theme.bold
                    anchors.verticalCenter: parent.verticalCenter
                    text: Media.trackTitle
                    color: Theme.foreground
        
                    SequentialAnimation on x {
                        running: titleText.width > title.width
                        loops: Animation.Infinite
            
                        // Wait 2 seconds at the start
                        PauseAnimation { duration: 2000 }
            
                        // Scroll to the left until the end is visible
                        NumberAnimation {
                            to: -(titleText.width - title.width)
                            duration: titleText.width * 15 // Speed depends on length
                            easing.type: Easing.Linear
                        }
            
                        // Wait 1 second at the end
                        PauseAnimation { duration: 1000 }
            
                        // Snap back to the beginning
                        PropertyAction { target: titleText; property: "x"; value: 0 }
                    }
                }
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            width: popupWidth 
            implicitHeight: 15
            color: "transparent"
            visible: true

            Text {
                id: playTime
                font.pixelSize: Theme.fontsize2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                text: Media.prettyPosition
                color: Theme.foreground
            }

            BarSlider {
                id: barslider
                isVertical: false
                anchors.centerIn: parent
                thickness: 8
                length: popupWidth - Math.max(playTime.contentWidth, playTimeLeft.contentWidth)*2 - 5
                  
                sliderfgval: Theme.foreground
                sliderbgval: Theme.foreground
                value: (Media.position/Media.length) ?? 0
                onMoved: (newValue) => {
                    Media.player.position = newValue * Media.player.length
                    //console.log("value: " + (Media.position/Media.length))
                    //console.log("newValue: " + (newValue * Media.length))
                }
            }

            Text {
                id: playTimeLeft
                font.pixelSize: Theme.fontsize2
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                text: "-" + Media.prettyRemainder
                color: Theme.foreground
            }
        } 

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            width: popupWidth 
            height: 40
            color: Qt.darker(Theme.foreground, 4)
            radius: Theme.bigradius

            Row {
                spacing: 8
                anchors.centerIn: parent
                component MediaControl: Rectangle {
                    id: controls
                    color: {
                        if (mediaSupport) return (mouse.hovered ? controls.hoverColor : Theme.foreground)
                        return Theme.foreground
                    }
                    border.width: 1
                    border.color: Theme.foreground
                    width: Theme.widgetwidth
                    height: Theme.widgetwidth
                    radius: Theme.smallradius
                    opacity: mediaSupport ? 1 : 0.4 
                    property alias icon: selectorIcon.text
                    property alias color: controls.color
                    property alias iconColor: selectorIcon.color
                    property alias mediaOpacity: controls.opacity
                    property bool mediaSupport: false
                    property color hoverColor: Qt.darker(Theme.foreground, 5)
                    Text {
                        id: selectorIcon
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontsize1
                        font.bold: true
                        color: {
                            if (mediaSupport) return (mouse.hovered ? Qt.lighter(Theme.foreground, 2) : Theme.background)
                            return Theme.background
                        }
                        text: ""
                    }

                    HoverHandler { id: mouse }

                    TapHandler {
                        id: tap
                        onTapped: {
                            /*console.log("Shuffle Supported: " + Media.shuffleSupported)
                            console.log("Shuffle State: " + Media.shuffle)
                            console.log("Loop Supported: " + Media.loopSupported)
                            console.log("Loop State: " + Media.loopState)*/
                            if (icon === "") Media.player.previous()
                            if ((icon === "") && Media.shuffleSupported) Media.shuffle = !Media.shuffle
                            if (icon === "" || icon === " ") Media.player.togglePlaying()
                            if ((icon === "") && Media.loopSupported) {}
                            if (icon === "") Media.player.next()
                        }
                    }
                }

                MediaControl {
                    icon: ""
                    mediaSupport: Media.shuffleSupported
                }
                MediaControl {
                    icon: ""
                    mediaSupport: Media.canGoPrevious
                }
                MediaControl {
                    icon: Media.isPlaying ? "" : " "
                    mediaSupport: Media.canTogglePlaying
                }
                MediaControl {
                    icon: ""
                    mediaSupport: Media.canGoNext
                }
                MediaControl {
                    icon: ""
                    mediaSupport: Media.loopSupported
                    }
            }
        }
    }
}

// TODO
// maybe clicking on left/right side of image skips forward or backwards 5s