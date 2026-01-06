// Gruvbox.qml
import QtQuick

QtObject {
    property color background   :   "#282828" // Gruvbox Dark 0 (Hard background)
    property color on_background:   "#fbf1c7" // Gruvbox fg0
        
    property color foreground   :   "#ebdbb2" // Gruvbox fg1 (Main text color)                                     // Alternative: "#d65d0e" (Dark Orange) or "#fabd2f" (Yellow) depending on pref.
        
    property color hover        :   "#504945" // Gruvbox Dark 2 (Lighter background for hover states)
    property color accent       :   "#83a598" // Gruvbox blue 
    property color accent2      :   "#8ec07c" // Gruvbox aqua 
    property color accent3      :   "#d3869b" // Gruvbox purple 
    property color accent4      :   "#fabd2f" // Gruvbox yellow 
        
    property color bordercol    :   "#8ec07c" // Gruvbox aqua 
    property color error        :   "#fb4934" // Gruvbox Bright Red (More alarming)
}