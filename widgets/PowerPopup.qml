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
    baseWidth: background.width + padding / 2
    baseHeight: background.height + padding / 2

    inverseCornerBottom: 0

    // 1. ANCHOR SETTINGS
    anchor.gravity: Edges.Right | Edges.Top     // Expand towards the top right
    anchor.margins.bottom: -Theme.widgetwidth - Theme.widgetmargin * 2

    Process {
        id: cmd
    }

    // 2. Define Exec Function at Root Level
    function exec(cmdString) {
        cmd.command = ["bash", "-c", cmdString];
        cmd.running = true;
        popup.closeAnimated();
    }
    Rectangle {
        id: background
        anchors.centerIn: parent
        width: grid.width + padding
        height: grid.height + padding
        color: Theme.surface_container
        radius: Theme.bigradius
        GridLayout {
            id: grid
            anchors.centerIn: parent

            columns: 3
            columnSpacing: 10
            rowSpacing: 10

            // --- THE BUTTONS ---

            PowerBtn {
                icon: "\uf023"              //
                label: "Lock"
            }
            PowerBtn {
                icon: "\uDB82\uDD04"        //󰤄
                label: "Sleep"
            }
            PowerBtn {
                icon: "\uDB80\uDF43"        //󰍃
                label: "Logout"
            }
            PowerBtn {
                icon: "\uf011"              //
                label: "Shutdown"
            }
            PowerBtn {
                icon: "\uf0e2"              //
                label: "Restart"
            }
            PowerBtn {
                icon: "\uDB82\uDD01"        //󰤁
                label: "Hibernate"
            }
        }
    }

    // 2. Button Component (Reusable)
    // We make a small component here to avoid repeating code
    component PowerBtn: ColumnLayout {
        id: btns
        property alias icon: iconText.text
        property alias label: labelText.text
        property color hoverColor: Theme.on_tertiary
        property color normalColor: Theme.on_primary

        // Allow clicking
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 70
            Layout.minimumWidth: 70
            radius: Math.min(Theme.bigradius, 16)
            color: mouse.hovered ? Theme.tertiary : Theme.primary

            // Put the column inside the rectangle background
            Column {
                anchors.centerIn: parent
                spacing: 5

                Text {
                    id: iconText
                    text: ""
                    font.pixelSize: Theme.fontsize1 * 2
                    color: mouse.hovered ? btns.hoverColor : btns.normalColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: labelText
                    text: ""
                    font.pixelSize: Theme.fontsize2
                    font.bold: true
                    color: mouse.hovered ? btns.hoverColor : btns.normalColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            TapHandler {
                id: tap
                onTapped: {
                    if (label == "Lock")
                        exec("hyprlock");
                    if (label == "Sleep")
                        exec("systemctl suspend");
                    if (label == "Shutdown")
                        exec("shutdown now");
                    if (label == "Restart")
                        exec("systemctl reboot");
                    if (label == "Logout")
                        exec("hyprshutdown && hyprctl dispatch exit");
                    if (label == "Hibernate")
                        exec("systemctl hybrid-sleep");
                    //console.log("Clicked " + labelText.text)
                }
            }
            HoverHandler {
                id: mouse
            }
        }
    }

    Item {
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
                    inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust2: -popup.height + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "RIGHT"
                // Bar is on Right -> Popup on Left
                PropertyChanges {
                    target: popup
                    inverseCornerBottom: 0
                    //anchor.gravity: Edges.Left | Edges.Top
                    edgeAdjust2: -popup.height + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "TOP"
                // Bar is Top -> Popup on Bottom
                PropertyChanges {
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust2: -popup.width + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            },
            State {
                name: "BOTTOM"
                // Bar is Bottom -> Popup on Top
                PropertyChanges {
                    target: popup
                    //inverseCornerBottom: 0
                    anchor.gravity: Edges.Right | Edges.Top
                    edgeAdjust2: -popup.width + Theme.widgetwidth + Theme.widgetmargin * 2
                }
            }
        ]
    }
}
