// Gruvbox.qml
import QtQuick

QtObject {
    // ---------------------------------------------------------------------------
    // SURFACE PALETTE
    // ---------------------------------------------------------------------------

    // The main hard background (Gruvbox Dark 0).
    property color surface                 :   "#282828" 
    
    // Slightly lighter background (Gruvbox Dark 1).
    property color surface_bright          :   "#3c3836" 
    
    // Main text color (Gruvbox fg1).
    property color on_surface              :   "#ebdbb2" 
    
    // Borders/Dividers (Gruvbox Gray 245).
    property color outline                 :   "#928374" 
    
    // Softer borders (Gruvbox Dark 4).
    property color outline_variant         :   "#7c6f64" 

    // ---------------------------------------------------------------------------
    // SURFACE CONTAINERS
    // ---------------------------------------------------------------------------

    // Hardest contrast (Gruvbox Dark Hard).
    property color surface_container_lowest:   "#1d2021" 
    
    // Standard background (Dark 0).
    property color surface_container_low   :   "#282828" 
    
    // Elevated background (Dark 1).
    property color surface_container       :   "#3c3836" 
    
    // High emphasis (Dark 2).
    property color surface_container_high  :   "#504945" 
    
    // Highest emphasis (Dark 3).
    property color surface_container_highest:  "#665c54" 

    // ---------------------------------------------------------------------------
    // PRIMARY PALETTE (Blue)
    // ---------------------------------------------------------------------------

    // Gruvbox Blue (Bright).
    property color primary                 :   "#83a598" 
    
    // Text on primary (Dark 0 for contrast).
    property color on_primary              :   "#282828" 
    
    // Variant: Gruvbox Blue (Neutral/Darker).
    property color primary_fixed           :   "#458588" 
    
    // Content on primary_fixed.
    property color on_primary_fixed        :   "#fbf1c7" 

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE (Aqua)
    // ---------------------------------------------------------------------------

    // Gruvbox Aqua (Bright).
    property color secondary               :   "#8ec07c" 
    
    // Text on secondary.
    property color on_secondary            :   "#282828" 
    
    // Variant: Gruvbox Aqua (Neutral/Darker).
    property color secondary_fixed         :   "#689d6a" 
    
    // Content on secondary_fixed.
    property color on_secondary_fixed      :   "#fbf1c7" 

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE (Yellow/Orange)
    // ---------------------------------------------------------------------------

    // Gruvbox Yellow (Bright).
    property color tertiary                :   "#fabd2f" 
    
    // Text on tertiary.
    property color on_tertiary             :   "#282828" 
    
    // Variant: Gruvbox Orange (Bright).
    property color tertiary_fixed          :   "#fe8019" 
    
    // Content on tertiary_fixed.
    property color on_tertiary_fixed       :   "#282828" 

    // ---------------------------------------------------------------------------
    // ERROR PALETTE (Red)
    // ---------------------------------------------------------------------------

    // Gruvbox Red (Bright).
    property color error                   :   "#fb4934" 
    
    // Text on error.
    property color on_error                :   "#282828" 
    
    // Error container: Gruvbox Red (Neutral/Darker).
    property color error_container         :   "#cc241d" 
    
    // Text on error container.
    property color on_error_container      :   "#ebdbb2" 

    // ---------------------------------------------------------------------------
    // INVERSE PALETTE
    // ---------------------------------------------------------------------------

    // Opposite surface (Light background - Gruvbox Light 0).
    property color inverse_surface         :   "#fbf1c7" 
    
    // Text on inverse surface.
    property color inverse_on_surface      :   "#282828" 
    
    // Action color on inverse (Gruvbox Purple).
    property color inverse_primary         :   "#d3869b" 
}