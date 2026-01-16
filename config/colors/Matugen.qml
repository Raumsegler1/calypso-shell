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
    property color primary                 :   "#ffb4a7"
    
    // Color for text and icons sitting on top of 'primary' components.
    property color on_primary              :   "#5d140a"
    
    // A color variant that stays similar in both Light and Dark themes. Stronger than container.
    property color primary_fixed           :   "#ffdad4"
    
    // Text/Icon color for content on top of 'primary_fixed'.
    property color on_primary_fixed        :   "#400200"

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE
    // Less prominent components (filter chips, tone-downed buttons).
    // ---------------------------------------------------------------------------

    // Used for less prominent components, like filter chips or non-active states.
    property color secondary               :   "#e7bdb6"
    
    // Color for text and icons sitting on top of 'secondary' components.
    property color on_secondary            :   "#422823"
    
    // Secondary variant that stays similar in both Light and Dark themes.
    property color secondary_fixed         :   "#ffdad4"
    
    // Text/Icon color for content on top of 'secondary_fixed'.
    property color on_secondary_fixed      :   "#2c1511"

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE
    // Accents and contrasting elements that balance Primary/Secondary.
    // ---------------------------------------------------------------------------

    // Accent color used to break up the monotony of primary/secondary colors.
    property color tertiary                :   "#ddc48c"
    
    // Color for text and icons sitting on top of 'tertiary' components.
    property color on_tertiary             :   "#3c2d03"
    
    // Tertiary variant that stays similar in both Light and Dark themes.
    property color tertiary_fixed          :   "#fbe0a6"
    
    // Text/Icon color for content on top of 'tertiary_fixed'.
    property color on_tertiary_fixed       :   "#251a00"

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
    property color inverse_primary         :   "#9c4234"
}
