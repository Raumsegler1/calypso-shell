import QtQuick
import QtQuick.Controls 
import QtQuick.Layouts
import QtQml.Models
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.config

ClippingRectangle {
    id: root
    
    // --- SIZING ---
    // Calculate height: (Count * Size) capped at 5 items.
    // If count is 0, default to size of 1 item so it's not invisible.
    property int itemSize: Theme.widgetwidth - padding
    property int spacing: 5
    property int padding: Theme.widgetmargin/2 // Total padding around the list
    
    implicitWidth: list.width + padding
    implicitHeight: list.height + padding
    
    color: Theme.surface_container_highest
    radius: Theme.smallradius
    border.color: Theme.outline_variant
    border.width: Theme.borderwidth
    
    // --- THE HIGHLIGHT (The moving box) ---
    Component {
        id: highlightComp
        Rectangle {
            z: 0
            color: Theme.primary
            border.color: Theme.outline
            border.width: Theme.borderwidth
            radius: Theme.smallradius
            
            // This makes it slide smoothly
            Behavior on y { SpringAnimation { spring: 1; damping: 0.2 } }
        }
    }

    // --- THE LIST ---
    ListView {
        id: list
        anchors.centerIn: parent
        width: root.itemSize
        
        // Dynamic Height: Content height, but capped at 6 items max
        height: Math.min((6 * root.itemSize) + (4 * root.spacing),contentHeight)

        clip: true 
        spacing: 3
        boundsBehavior: Flickable.StopAtBounds 

        model: Hyprland.workspaces

        // Attach the highlight component
        highlight: highlightComp
        highlightFollowsCurrentItem: true 

        Component.onCompleted: {
            // "If Hyprland has a focused workspace, set my index to match it"
            if (Hyprland.focusedWorkspace) {
                list.currentIndex = Hyprland.focusedWorkspace.id - 1
            }
        }

        Connections {
            target: Hyprland
            function onFocusedWorkspaceChanged() {
                if (Hyprland.focusedWorkspace) {
                    list.currentIndex = Hyprland.focusedWorkspace.id - 1
                }
            }
        }

        // --- THE DELEGATE (The Workspace Item) ---
        delegate: Rectangle {
            z: 1
            width: root.itemSize
            height: Math.max(root.itemSize, contentCol.height + 10)
            
            readonly property string displayLabel: modelData.id < 0 ? "" : modelData.id
            readonly property bool isSpecial: modelData.id < 0
            readonly property bool isActive: modelData.id === Hyprland.focusedWorkspace.id
            
            color: {
                if (mouse.hovered && !isSpecial && !isActive) return Theme.tertiary
                if (isSpecial) return Theme.primary
                return "transparent"
            }

            radius: Theme.smallradius

            Column {
                id: contentCol
                anchors.centerIn: parent
                spacing: -5
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: Theme.fontsize1
                    text: modelData.id < 0 ? "" : modelData.id
                    color: {
                        if (mouse.hovered && !isSpecial && !isActive) return Theme.on_tertiary
                        if (isSpecial || isActive) return Theme.on_primary
                        return Theme.secondary
                    }
                    font.bold: Theme.bold
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: -5
                    Repeater {
                        model: modelData.toplevels.values
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Theme.fontsize2
                            text: matchIcon(modelData.wayland?.appId)
                            color: {
                                if (mouse.hovered && !isSpecial && !isActive) return Theme.on_tertiary
                                if (isSpecial || isActive) return Theme.on_primary
                                return Theme.secondary
                            }
                            font.bold: Theme.bold
                        }   
                    }
                }
            }
            
            // The Click
            TapHandler {
                onTapped: {
                    //modelData.toplevels.values.forEach(function(toplevel) {  
                    //    console.log(toplevel.wayland.appId)  
                    //}) 
                    if (modelData.id < 0) return 
                    if (modelData.id !== Hyprland.focusedWorkspace.id) return modelData.activate()
                }
            } 
            
            HoverHandler { 
                id: mouse 
                onHoveredChanged: {
                }
            }
        }
    }
    function matchIcon(appId) {
        if (!appId) return ""//"" // Default generic window icon
        
        // Convert to lowercase just in case
        const id = appId.toLowerCase()

        const iconMap = {
            // Terminals
            "kitty": "",
            "alacritty": "",
            "foot": "",
            
            // Browsers
            "firefox": "󰈹",
            "chromium-browser": "",
            "google-chrome": "",
            "librewolf": "󰈹",
            
            // Editors
            "code": "󰨞",
            "codium": "󰨞",
            "nvim": "",
            "vim": "",
            "onlyoffice": "󰈙",
            "org.kde.kate": "󰷈",
            "org.kde.kwrite": "󰈮",

            
            // Chat / Social
            "discord": "",
            "vesktop": "",
            "slack": "",
            "telegram-desktop": "",
            "whatsapp": "󰖣",
            
            // System
            "org.kde.dolphin": "",
            "org.kde.gwenview": "󰈟",
            "org.kde.okular": "󰱼",
            "thunar": "",
            "nemo": "",
            "spotify": "",
            "vlc": "󰕼",
            "thunderbird": "󰇮"
        }

        // Return the icon if found, otherwise return a default 'unknown' icon
        return iconMap[id] || ""//""
    }
}

// modelData.toplevels.values[0].wayland.appId

//animate color: Behavior on color { ColorAnimation { duration: 200 } }

// "image://icon/" is a magic Qt provider that grabs the icon from your Linux theme
// source: "image://icon/" + (modelData.wayland.appId ||  "")
