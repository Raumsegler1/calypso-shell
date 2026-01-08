// Nord.qml
import QtQuick

QtObject {
    // The neutral background color for the app (using Nord Polar Night).
    property color surface                 :   "#2E3440" // nord0
    
    // The brightest surface color.
    property color surface_bright          :   "#3B4252" // nord1
    
    // Color for text and icons displayed on top of the 'surface' color (Snow Storm).
    property color on_surface              :   "#ECEFF4" // nord6
    
    // Used for boundaries and dividers.
    property color outline                 :   "#4C566A" // nord3
    
    // A softer version of outline.
    property color outline_variant         :   "#434C5E" // nord2

    // ---------------------------------------------------------------------------
    // SURFACE CONTAINERS (Polar Night Levels)
    // ---------------------------------------------------------------------------

    // The darkest background role.
    property color surface_container_lowest:   "#242933" // Custom Darker nord0
    
    // Low emphasis background.
    property color surface_container_low   :   "#2E3440" // nord0
    
    // The default background for large contained areas.
    property color surface_container       :   "#3B4252" // nord1
    
    // Higher emphasis background.
    property color surface_container_high  :   "#434C5E" // nord2
    
    // Highest emphasis background.
    property color surface_container_highest:  "#4C566A" // nord3

    // ---------------------------------------------------------------------------
    // PRIMARY PALETTE (Frost - Cyan/Teal)
    // ---------------------------------------------------------------------------

    // Main color (nord8 - Cyan).
    property color primary                 :   "#88C0D0" // nord8
    
    // Text on primary (Dark Polar Night for contrast).
    property color on_primary              :   "#2E3440" // nord0
    
    // Variant (nord7 - Teal).
    property color primary_fixed           :   "#8FBCBB" // nord7
    
    // Content on primary_fixed.
    property color on_primary_fixed        :   "#2E3440" // nord0

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE (Frost - Deep Blues)
    // ---------------------------------------------------------------------------

    // Less prominent components (nord10 - Deep Blue).
    property color secondary               :   "#5E81AC" // nord10
    
    // Text on secondary (Snow Storm for contrast).
    property color on_secondary            :   "#ECEFF4" // nord6
    
    // Secondary variant (nord9 - Glacial Blue).
    property color secondary_fixed         :   "#81A1C1" // nord9
    
    // Content on secondary_fixed.
    property color on_secondary_fixed      :   "#2E3440" // nord0

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE (Aurora - Purple)
    // ---------------------------------------------------------------------------

    // Accent color (nord15 - Purple).
    property color tertiary                :   "#B48EAD" // nord15
    
    // Text on tertiary.
    property color on_tertiary             :   "#2E3440" // nord0
    
    // Tertiary variant (lighter purple simulated or nord15 reused).
    property color tertiary_fixed          :   "#D08770" // nord12 (Orange - to add warmth variation)
    
    // Content on tertiary_fixed.
    property color on_tertiary_fixed       :   "#2E3440" // nord0

    // ---------------------------------------------------------------------------
    // ERROR PALETTE (Aurora - Red)
    // ---------------------------------------------------------------------------

    // Error state (nord11 - Red).
    property color error                   :   "#BF616A" // nord11
    
    // Text on error.
    property color on_error                :   "#2E3440" // nord0
    
    // Error container (using outline color as fallback or custom dark red).
    property color error_container         :   "#4C566A" // nord3 (Highlight Grey as container)
    
    // Text on error container.
    property color on_error_container      :   "#BF616A" // nord11

    // ---------------------------------------------------------------------------
    // INVERSE PALETTE
    // ---------------------------------------------------------------------------

    // Opposite surface (Snow Storm).
    property color inverse_surface         :   "#ECEFF4" // nord6
    
    // Text on inverse surface.
    property color inverse_on_surface      :   "#2E3440" // nord0
    
    // Action color on inverse surface (Deep Blue).
    property color inverse_primary         :   "#5E81AC" // nord10
}