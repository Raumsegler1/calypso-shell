// TokyoNight.qml
import QtQuick

QtObject {
    // ---------------------------------------------------------------------------
    // SURFACE PALETTE
    // ---------------------------------------------------------------------------

    // The main background (Tokyo Night "Moon" variant).
    property color surface                 :   "#222436" 
    
    // A slightly lighter surface for differentiation.
    property color surface_bright          :   "#2f334d" 
    
    // The main text color.
    property color on_surface              :   "#c8d3f5" 
    
    // Borders/Dividers (using the bright black/grey).
    property color outline                 :   "#444a73" 
    
    // Softer borders (inactive tab bg).
    property color outline_variant         :   "#2f334d" 

    // ---------------------------------------------------------------------------
    // SURFACE CONTAINERS
    // ---------------------------------------------------------------------------

    // Darkest shade (Tokyo Night "Storm" / color0).
    property color surface_container_lowest:   "#1b1d2b" 
    
    // Low emphasis.
    property color surface_container_low   :   "#1e2030" 
    
    // Default container (matches main background).
    property color surface_container       :   "#222436" 
    
    // High emphasis (Inactive element background).
    property color surface_container_high  :   "#2f334d" 
    
    // Highest emphasis (Bright Black / Comment color).
    property color surface_container_highest:  "#444a73" 

    // ---------------------------------------------------------------------------
    // PRIMARY PALETTE (Blue)
    // ---------------------------------------------------------------------------

    // The signature Tokyo Night Blue.
    property color primary                 :   "#82aaff" 
    
    // Text on primary (Dark).
    property color on_primary              :   "#1b1d2b" 
    
    // Variant (Cyan/Teal - color6).
    property color primary_fixed           :   "#86e1fc" 
    
    // Content on primary_fixed.
    property color on_primary_fixed        :   "#1b1d2b" 

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE (Purple)
    // ---------------------------------------------------------------------------

    // The Purple accent (color5).
    property color secondary               :   "#c099ff" 
    
    // Text on secondary.
    property color on_secondary            :   "#1b1d2b" 
    
    // Secondary variant (Bright Purple).
    property color secondary_fixed         :   "#caabff" 
    
    // Content on secondary_fixed.
    property color on_secondary_fixed      :   "#1b1d2b" 

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE (Orange/Gold)
    // ---------------------------------------------------------------------------

    // The Orange/Yellow accent (color3).
    property color tertiary                :   "#ffc777" 
    
    // Text on tertiary.
    property color on_tertiary             :   "#1b1d2b" 
    
    // Tertiary variant (Bright Orange).
    property color tertiary_fixed          :   "#ffd8ab" 
    
    // Content on tertiary_fixed.
    property color on_tertiary_fixed       :   "#1b1d2b" 

    // ---------------------------------------------------------------------------
    // ERROR PALETTE (Red)
    // ---------------------------------------------------------------------------

    // The Red accent (color1).
    property color error                   :   "#ff757f" 
    
    // Text on error.
    property color on_error                :   "#1b1d2b" 
    
    // Error container (Extended red).
    property color error_container         :   "#c53b53" 
    
    // Text on error container.
    property color on_error_container      :   "#c8d3f5" 

    // ---------------------------------------------------------------------------
    // INVERSE PALETTE
    // ---------------------------------------------------------------------------

    // Opposite surface (Light Text color).
    property color inverse_surface         :   "#c8d3f5" 
    
    // Text on inverse surface (Dark Background).
    property color inverse_on_surface      :   "#222436" 
    
    // Action color on inverse (Green - color2 for contrast).
    property color inverse_primary         :   "#c3e88d" 
}
/*
background "#222436"
foreground "#c8d3f5"
selection_background #2d3f76
selection_foreground #c8d3f5
url_color #4fd6be
cursor #c8d3f5
cursor_text_color #222436

# Tabs
active_tab_background "#82aaff"
active_tab_foreground "#1e2030"
inactive_tab_background "#2f334d"
inactive_tab_foreground "#545c7e"
#tab_bar_background "#1b1d2b"

# Windows
active_border_color "#82aaff"
inactive_border_color "#2f334d"

# normal
color0 "#1b1d2b"
color1 "#ff757f"
color2 "#c3e88d"
color3 "#ffc777"
color4 "#82aaff"
color5 "#c099ff"
color6 "#86e1fc"
color7 "#828bb8"

# bright
color8  #444a73
color9  #ff8d94
color10 #c7fb6d
color11 #ffd8ab
color12 #9ab8ff
color13 #caabff
color14 #b2ebff
color15 #c8d3f5

# extended colors
color16 #ff966c
color17 #c53b53