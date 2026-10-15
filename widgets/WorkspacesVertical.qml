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
    property int padding: Theme.widgetmargin / 2 // Total padding around the list

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
            Behavior on y {
                SpringAnimation {
                    spring: 1
                    damping: 0.2
                }
            }
        }
    }

    // --- THE LIST ---
    ListView {
        id: list
        anchors.centerIn: parent
        width: Theme.isVertical ? root.itemSize : (Math.min((6 * root.itemSize) + (4 * root.spacing), contentWidth))
        height: Theme.isVertical ? (Math.min((6 * root.itemSize) + (4 * root.spacing), contentHeight)) : root.itemSize

        // 1. IMPORTANT: Set orientation so the list actually lays out horizontally when needed
        orientation: Theme.isVertical ? ListView.Vertical : ListView.Horizontal

        clip: true
        spacing: 3
        boundsBehavior: Flickable.StopAtBounds

        model: Hyprland.workspaces

        // Attach the highlight component
        highlight: highlightComp
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: Theme.isVertical ? list.height : list.width
        highlightMoveDuration: 250

        //Component.onCompleted: {
        // "If Hyprland has a focused workspace, set my index to match it"
        //    if (Hyprland.focusedWorkspace) {
        //        list.currentIndex = Hyprland.focusedWorkspace.id - 1;
        //    }
        //}
        Component.onCompleted: root.syncCurrent()

        Connections {
            target: Hyprland
            function onFocusedWorkspaceChanged() {
                root.syncCurrent();
            }
        }

        // Workspaces get created and destroyed, which shifts indexes
        Connections {
            target: Hyprland.workspaces
            function onValuesChanged() {
                root.syncCurrent();
            }
        }

        // --- THE DELEGATE (The Workspace Item) ---
        delegate: Rectangle {
            z: 1
            width: Theme.isVertical ? root.itemSize : Math.max(root.itemSize, container.width + 10)
            height: Theme.isVertical ? Math.max(root.itemSize, container.height + 10) : root.itemSize

            readonly property string displayLabel: modelData.id < 0 ? "" : modelData.id
            readonly property bool isSpecial: modelData.id < 0
            readonly property bool isActive: modelData.id === Hyprland.focusedWorkspace?.id

            color: {
                if (mouse.hovered && !isSpecial && !isActive)
                    return Theme.tertiary;
                if (isSpecial)
                    return Theme.primary;
                return "transparent";
            }

            radius: Theme.smallradius

            Item {
                id: container
                anchors.centerIn: parent
                // Size the container to fit the loaded content
                implicitWidth: loader.item.implicitWidth
                implicitHeight: loader.item.implicitHeight

                Loader {
                    id: loader
                    anchors.centerIn: parent
                    sourceComponent: Theme.isVertical ? verticalLayout : horizontalLayout
                }

                // --- OPTION 1: Vertical Layout (Column) ---
                Component {
                    id: verticalLayout
                    Column {
                        spacing: -5

                        // Workspace ID
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Theme.fontsize1
                            font.bold: Theme.bold
                            text: modelData.id < 0 ? "" : modelData.id
                            color: container.getColor(mouse.hovered, isSpecial, isActive)
                        }

                        // Windows List
                        Column {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: -5
                            Repeater {
                                model: modelData.toplevels.values
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.pixelSize: Theme.fontsize2
                                    font.bold: Theme.bold
                                    text: matchIcon(modelData.wayland?.appId)
                                    color: container.getColor(mouse.hovered, isSpecial, isActive)
                                }
                            }
                        }
                    }
                }

                // --- OPTION 2: Horizontal Layout (Row) ---
                Component {
                    id: horizontalLayout
                    Row {
                        spacing: 5 // Positive spacing looks better in rows usually

                        // Workspace ID
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: Theme.fontsize1
                            font.bold: Theme.bold
                            text: modelData.id < 0 ? "" : modelData.id
                            color: container.getColor(mouse.hovered, isSpecial, isActive)
                        }

                        // Windows List
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2
                            Repeater {
                                model: modelData.toplevels.values
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: Theme.fontsize2
                                    font.bold: Theme.bold
                                    text: matchIcon(modelData.wayland?.appId)
                                    color: container.getColor(mouse.hovered, isSpecial, isActive)
                                }
                            }
                        }
                    }
                }

                // --- HELPER FUNCTION ---
                // Since logic is identical for both, we define it once here to keep code clean.
                function getColor(isHovered, isSpecial, isActive) {
                    if (isHovered && !isSpecial && !isActive)
                        return Theme.on_tertiary;
                    if (isSpecial || isActive)
                        return Theme.on_primary;
                    return Theme.primary;
                }
            }

            // The Click
            TapHandler {
                onTapped: {
                    if (modelData.id < 0 || isActive)
                        return;
                    modelData.activate();
                }
            }

            HoverHandler {
                id: mouse
                onHoveredChanged: {}
            }
        }
    }

    // Find the focused workspace's position in the model and point the list at it
    function syncCurrent() {
        const fw = Hyprland.focusedWorkspace;
        if (!fw)
            return;
        const idx = Hyprland.workspaces.values.findIndex(w => w.id === fw.id);
        if (idx < 0)
            return;
        list.currentIndex = idx;
    }

    function matchIcon(appId) {
        if (!appId)
            return "";//"" // Default generic window icon

        // Convert to lowercase just in case
        const id = appId.toLowerCase();

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
        };

        // Return the icon if found, otherwise return a default 'unknown' icon
        return iconMap[id] || "";
    }
}

// modelData.toplevels.values[0].wayland.appId

//animate color: Behavior on color { ColorAnimation { duration: 200 } }

// "image://icon/" is a magic Qt provider that grabs the icon from your Linux theme
// source: "image://icon/" + (modelData.wayland.appId ||  "")
