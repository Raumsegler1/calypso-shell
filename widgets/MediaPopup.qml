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
    property real padding: Theme.widgetmargin * 3
    heightPadding: padding
    baseWidth: background.width + padding
    baseHeight: background.height + padding
    cornerRadius: Math.min(16, Theme.bigradius)

    Rectangle {
        id: background
        anchors.centerIn: parent
        anchors.margins: padding
        color: Theme.surface_container
        width: content.width + padding
        height: content.height + padding
        radius: Math.min(16, Theme.bigradius)
        Column {
            id: content
            anchors.centerIn: parent
            spacing: Theme.widgetmargin

            ClippingRectangle {
                width: popupWidth
                height: popupWidth
                radius: Theme.bigradius
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    id: coverArt
                    anchors.centerIn: parent
                    anchors.margins: 20
                    fillMode: Image.PreserveAspectCrop
                    width: parent.width
                    height: parent.height
                    source: Media.trackArtUrl
                    layer.enabled: true
                    layer.live: true
                    layer.effect: MultiEffect {
                        colorization: Media.isPlaying ? 0 : 0.8
                        colorizationColor: Theme.secondary
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

                            // M3: Active state uses Tertiary (Accent), Inactive uses Surface Container
                            color: popup.pinned ? Theme.tertiary_fixed : Theme.surface_container_highest
                            opacity: pinMouse.hovered ? 1.0 : 0.8 // Opacity shift for hover

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }
                        }

                        Text {
                            id: selectorIcon
                            anchors.centerIn: parent
                            font.pixelSize: Theme.fontsize1
                            font.bold: true

                            // M3: Text contrast matching the container
                            color: popup.pinned ? Theme.on_tertiary_fixed : Theme.on_surface
                            text: popup.pinned ? " " : ""
                        }

                        HoverHandler {
                            id: pinMouse
                        }
                        TapHandler {
                            onTapped: {
                                popup.pinned = !popup.pinned;
                                //console.log(popup.pinned)
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: controlGroup
                anchors.horizontalCenter: parent.horizontalCenter

                // M3: Use the full width minus padding for the container
                width: popupWidth

                // Calculate height based on children + padding
                height: actions.height + Theme.widgetmargin

                radius: Theme.bigradius

                // M3: Use a Surface Container color, not Primary (which is too intense for backgrounds)
                color: Theme.surface_container_highest

                Column {
                    id: actions
                    anchors.centerIn: parent
                    width: parent.width - Theme.widgetwidth
                    spacing: 0 // Tighter spacing for a cohesive look

                    // --- TITLE ---
                    Rectangle {
                        id: titleContainer
                        clip: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 30
                        width: parent.width
                        color: "transparent"

                        Text {
                            id: titleText
                            font.pixelSize: Theme.fontsize2
                            font.bold: Theme.bold
                            anchors.verticalCenter: parent.verticalCenter
                            // If text fits, center it; otherwise left align for scrolling
                            anchors.horizontalCenter: width < parent.width ? parent.horizontalCenter : undefined

                            text: Media.trackTitle
                            color: Theme.secondary

                            SequentialAnimation on x {
                                running: titleText.width > titleContainer.width
                                loops: Animation.Infinite
                                PauseAnimation {
                                    duration: 2000
                                }
                                NumberAnimation {
                                    to: -(titleText.width - titleContainer.width)
                                    duration: titleText.width * 15
                                    easing.type: Easing.Linear
                                }
                                PauseAnimation {
                                    duration: 1000
                                }
                                PropertyAction {
                                    target: titleText
                                    property: "x"
                                    value: 0
                                }
                            }
                        }
                    }

                    // --- PROGRESS ---
                    Rectangle {
                        id: progressBar
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width + 10
                        height: 20
                        color: "transparent"

                        property color textCol: Theme.secondary

                        Text {
                            id: playTime
                            font.pixelSize: Theme.fontsize2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            text: Media.prettyPosition
                            color: progressBar.textCol
                        }

                        BarSlider {
                            id: barslider
                            isVertical: false
                            anchors.centerIn: parent
                            thickness: 8

                            // Calculate precise width to fit between timestamps
                            length: parent.width - Math.max(playTime.contentWidth, playTimeLeft.contentWidth) * 2 - 10

                            // M3: Active part is Primary, Inactive part is Secondary/Outline
                            sliderfgcol: progressBar.textCol
                            sliderbgcol: Theme.outline_variant

                            value: (Media.position / Media.length) ?? 0
                            onMoved: newValue => {
                                Media.player.position = newValue * Media.player.length;
                            }
                        }

                        Text {
                            id: playTimeLeft
                            font.pixelSize: Theme.fontsize2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: "-" + Media.prettyRemainder
                            color: progressBar.textCol
                        }
                    }

                    // --- CONTROLS ---
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        height: buttons.height + Theme.widgetmargin * 2 // Fixed height for touch targets
                        color: "transparent"

                        Row {
                            id: buttons
                            spacing: 8
                            anchors.centerIn: parent

                            MediaControl {
                                icon: ""
                                mediaSupport: Media.shuffleSupported
                            }
                            MediaControl {
                                icon: ""
                                mediaSupport: Media.canGoPrevious
                            }
                            // Play Button - Slightly larger or distinct?
                            // We keep it same size but you could make it Primary filled.
                            MediaControl {
                                icon: Media.isPlaying ? "" : " "
                                mediaSupport: Media.canTogglePlaying
                                width: Theme.widgetwidth + 5
                                height: Theme.widgetwidth + 5
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
        }
    }

    component MediaControl: Rectangle {
        id: btnRoot
        width: Theme.widgetwidth
        height: Theme.widgetwidth
        radius: Theme.smallradius
        anchors.verticalCenter: parent.verticalCenter

        property alias icon: iconText.text
        property alias iconCol: iconText.color
        property bool mediaSupport: false

        color: {
            if (!mediaSupport)
                return Theme.outline; // Disabled
            return Theme.primary;
        }

        // Hover Effect (State Layer)
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "black"
            opacity: mouse.hovered && mediaSupport ? 0.24 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                }
            }
        }

        Text {
            id: iconText
            anchors.centerIn: parent
            font.pixelSize: Theme.fontsize1
            font.bold: true

            // M3: Icon Color Logic
            color: {
                if (!mediaSupport)
                    return Theme.outline_variant; // Disabled
                return Theme.on_primary;// Default
            }
        }

        HoverHandler {
            id: mouse
        }
        TapHandler {
            enabled: mediaSupport
            onTapped: {
                if (icon === "")
                    Media.player.previous();
                if ((icon === "") && Media.shuffleSupported)
                    Media.shuffle = !Media.shuffle;
                if (icon === "" || icon === " ")
                    Media.player.togglePlaying();
                if ((icon === "") && Media.loopSupported) { /* Loop logic */ }
                if (icon === "")
                    Media.player.next();
            }
        }
    }
}

// TODO
// maybe clicking on left/right side of image skips forward or backwards 5s
