// Windows11.qml
import QtQuick

QtObject {
    // Windows 11 Dark (Mica Alt)
    property color background   :   '#e3202020' 
    
    // System Accent (Windows Light Blue for Dark Mode)
    property color on_background:   "#0078D4" 

    // Text (Segoe UI White)
    property color foreground   :   "#ffffff"

    // Interaction Colors
    property color hover        :   "#4CC2FF" // Lighter Blue for hover states
    
    // The "Metro" Colors
    property color accent       :   "#0078D4" // Official Windows Brand Blue
    property color accent2      :   "#0078D4" // Xbox Green
    property color accent3      :   "#0078D4" // Warning Yellow
    property color accent4      :   "#0078D4"  // Windows Purple

    property color bordercol    :   "#3F3F3F" // Subtle Window Border (or use #60CDFF for active)
    property color error        :   "#C42B1C" // System Error Red
}