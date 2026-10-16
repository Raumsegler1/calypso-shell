import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.config
import qs.components
import qs.services

SidebarPopup {
    id: popup
    property real padding: 15
    baseWidth: background.width + padding
    baseHeight: background.height + padding
    anchor.margins.bottom: +Theme.widgetwidth + Theme.widgetmargin * 2 - popup.height
    inverseCornerTop: 0

    property color hoveredButton: Theme.tertiary
    property color surfaceButton: Theme.secondary
    property color onButton: Theme.primary
    property color containerColor: Theme.surface_container
    // ""
    // ""

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: 300
        height: content.height + popup.padding
        color: Theme.surface
        radius: Theme.bigradius

        Column {
            id: content
            anchors.centerIn: parent
            spacing: popup.padding

            Rectangle {
                id: uptimeUser
                anchors.horizontalCenter: parent.horizontalCenter
                width: background.width - popup.padding
                height: (uptimeUser.width) / 3
                radius: (Theme.bigradius > 20) ? uptimeUser.height / 2 : Theme.bigradius
                color: popup.containerColor

                Row {
                    anchors.fill: parent
                    anchors.margins: popup.padding / 2
                    spacing: 20

                    ClippingRectangle {
                        id: imgClip
                        anchors.verticalCenter: parent.verticalCenter
                        width: uptimeUser.height - popup.padding
                        height: uptimeUser.height - popup.padding
                        radius: (Theme.bigradius > 20) ? imgClip.height / 2 : Theme.smallradius
                        border.width: 2
                        border.color: Theme.primary
                        Image {
                            id: sourceImage
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectCrop
                            width: parent.width
                            height: parent.height
                            source: Theme.faceUrl
                            cache: false
                            asynchronous: true
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            color: Theme.primary
                            font.bold: Theme.bold
                            font.pixelSize: Theme.fontsize1 + 2
                            text: Theme.userName
                        }

                        Text {
                            color: Theme.tertiary
                            font.bold: Theme.bold
                            font.pixelSize: Theme.fontsize2
                            text: "Uptime: " + Uptime.prettyTime
                        }
                    }
                }
            }

            Rectangle {
                id: weather
                anchors.horizontalCenter: parent.horizontalCenter
                width: background.width - popup.padding
                height: (uptimeUser.width) / 3
                // Ensure radius is consistent
                radius: (Theme.bigradius > 20) ? height / 2 : Theme.bigradius
                color: popup.containerColor

                Row {
                    //anchors.centerIn: parent
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 30 // Add space between Icon, Text, and Temp

                    // 1. Weather Icon (Needs Icon Font)
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        width: Theme.fontsize1 * 3
                        color: Theme.primary
                        font.family: "Material Icons Round"
                        font.pixelSize: Theme.fontsize1 * 4
                        text: Weather.weatherIcon
                    }

                    // 2. Location & Details (Needs NORMAL Font)
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2

                        Text {
                            color: Theme.primary
                            font.bold: Theme.bold
                            font.pixelSize: Theme.fontsize1
                            text: Theme.cityLocation
                        }

                        Text {
                            color: Theme.tertiary
                            font.bold: Theme.bold
                            font.pixelSize: Theme.fontsize2
                            text: "It's " + Weather.temperature + " and " + Weather.weatherString
                        }
                    }
                }
            }
        }
    }

    Item {
        id: positionHandler
        // --- STATES (Moved INSIDE Item so they work) ---
        state: {
            if (Theme.barPosition === "right")
                return "RIGHT";
            if (Theme.barPosition === "top")
                return "TOP";
            if (Theme.barPosition === "bottom")
                return "BOTTOM";
            return "LEFT";
        }

        states: [
            State {
                name: "LEFT"
                // Bar is on Left -> Popup on Right
                PropertyChanges {
                    target: popup
                    inverseCornerTop: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: -popup.height + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "RIGHT"
                // Bar is on Right -> Popup on Left
                PropertyChanges {
                    target: popup
                    inverseCornerTop: 0
                    //anchor.gravity: Edges.Left | Edges.Top
                    edgeAdjust1: -popup.height + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "TOP"
                // Bar is Top -> Popup on Bottom
                PropertyChanges {
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: -popup.width + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "BOTTOM"
                // Bar is Bottom -> Popup on Top
                PropertyChanges {
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust1: -popup.width + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            }
        ]
    }
}
