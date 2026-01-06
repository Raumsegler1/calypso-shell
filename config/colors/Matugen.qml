import QtQuick

QtObject {
    // The neutral background color for the app (usually the darkest/lightest tone).
    property color surface                 :   "#131313"
    
    // The brightest surface color. In Dark Mode, it's slightly lighter than Surface; in Light Mode, it is white.
    property color surface_bright          :   "#3b3b3b"
    
    // Color for text and icons displayed on top of the 'surface' color.
    property color on_surface              :   "#e2e2e2"
    
    // Used for boundaries and dividers, like text field borders or card outlines.
    property color outline                 :   "#919191"
    
    // A softer version of outline, used for decorative dividers or disabled borders.
    property color outline_variant         :   "#525252"

    // ---------------------------------------------------------------------------
    // SURFACE CONTAINERS
    // These provide "elevation" without shadows. Use them for different layers.
    // ---------------------------------------------------------------------------

    // The darkest background role. Used for behind the app content if needed.
    property color surface_container_lowest:   "#0d0d0d"
    
    // Low emphasis background. Good for the main body of the app behind cards.
    property color surface_container_low   :   "#1c1c1c"
    
    // The default background for large contained areas (like a navigation drawer or card).
    property color surface_container       :   "#212121"
    
    // Higher emphasis background. Used for small cards or sections inside a container.
    property color surface_container_high  :   "#2c2c2c"
    
    // Highest emphasis background. Used for dialogs, modals, and popups.
    property color surface_container_highest:  "#363636"

    // ---------------------------------------------------------------------------
    // PRIMARY PALETTE
    // High-emphasis components (FABs, active buttons, switches).
    // ---------------------------------------------------------------------------

    // The main color of your app. Used for key components like the FAB or active states.
    property color primary                 :   "#d4bbff"
    
    // Color for text and icons sitting on top of 'primary' components.
    property color on_primary              :   "#3b1a6e"
    
    // A color variant that stays similar in both Light and Dark themes. Stronger than container.
    property color primary_fixed           :   "#ebdcff"
    
    // Text/Icon color for content on top of 'primary_fixed'.
    property color on_primary_fixed        :   "#270058"

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE
    // Less prominent components (filter chips, tone-downed buttons).
    // ---------------------------------------------------------------------------

    // Used for less prominent components, like filter chips or non-active states.
    property color secondary               :   "#cdc2db"
    
    // Color for text and icons sitting on top of 'secondary' components.
    property color on_secondary            :   "#332b3f"
    
    // Secondary variant that stays similar in both Light and Dark themes.
    property color secondary_fixed         :   "#eadef7"
    
    // Text/Icon color for content on top of 'secondary_fixed'.
    property color on_secondary_fixed      :   "#1f182a"

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE
    // Accents and contrasting elements that balance Primary/Secondary.
    // ---------------------------------------------------------------------------

    // Accent color used to break up the monotony of primary/secondary colors.
    property color tertiary                :   "#f1b7c4"
    
    // Color for text and icons sitting on top of 'tertiary' components.
    property color on_tertiary             :   "#49232d"
    
    // Tertiary variant that stays similar in both Light and Dark themes.
    property color tertiary_fixed          :   "#ffd9e0"
    
    // Text/Icon color for content on top of 'tertiary_fixed'.
    property color on_tertiary_fixed       :   "#32101a"

    // ---------------------------------------------------------------------------
    // ERROR PALETTE
    // Warnings and critical alerts.
    // ---------------------------------------------------------------------------

    // Used for text or icons that indicate an error state.
    property color error                   :   "#ffb4ab"
    
    // Color for text on top of 'error' (e.g. text on a red delete button).
    property color on_error                :   "#660004"
    
    // Used for the background of error messages (e.g. a red banner).
    property color error_container         :   "#a7060f"
    
    // Text color to use on top of 'error_container'.
    property color on_error_container      :   "#ffffff"

    // ---------------------------------------------------------------------------
    // INVERSE PALETTE
    // Used for things like Snackbars or dark toolbars in a light theme.
    // ---------------------------------------------------------------------------

    // The opposite of the current theme's surface (e.g. White in Dark Mode).
    property color inverse_surface         :   "#e2e2e2"
    
    // Text color on top of 'inverse_surface' (e.g. Black text on White snackbar in Dark Mode).
    property color inverse_on_surface      :   "#303030"
    
    // Action color on top of 'inverse_surface' (e.g. "Undo" button on a snackbar).
    property color inverse_primary         :   "#6d4ea1"


    // Other 

    property color background   :   "#131313"
    property color on_background:   "#e2e2e2"

    property color foreground   :   "#d4bbff"

    property color hover        :   "#cdc2db"
    property color accent       :   "#f1b7c4"
    property color accent2      :   "#d4bbff"
    property color accent3      :   "#d4bbff"
    property color accent4      :   "#d4bbff"

    property color bordercol    :   "#6d4ea1"
}
