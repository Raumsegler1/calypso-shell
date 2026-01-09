import QtQuick

QtObject {
    // The neutral background color for the app (usually the darkest/lightest tone).
    property color surface                 :   "#191113"
    
    // The brightest surface color. In Dark Mode, it's slightly lighter than Surface; in Light Mode, it is white.
    property color surface_bright          :   "#413739"
    
    // Color for text and icons displayed on top of the 'surface' color.
    property color on_surface              :   "#efdfe1"
    
    // Used for boundaries and dividers, like text field borders or card outlines.
    property color outline                 :   "#9e8c90"
    
    // A softer version of outline, used for decorative dividers or disabled borders.
    property color outline_variant         :   "#514347"

    // ---------------------------------------------------------------------------
    // SURFACE CONTAINERS
    // These provide "elevation" without shadows. Use them for different layers.
    // ---------------------------------------------------------------------------

    // The darkest background role. Used for behind the app content if needed.
    property color surface_container_lowest:   "#140c0e"
    
    // Low emphasis background. Good for the main body of the app behind cards.
    property color surface_container_low   :   "#22191c"
    
    // The default background for large contained areas (like a navigation drawer or card).
    property color surface_container       :   "#261d20"
    
    // Higher emphasis background. Used for small cards or sections inside a container.
    property color surface_container_high  :   "#31282a"
    
    // Highest emphasis background. Used for dialogs, modals, and popups.
    property color surface_container_highest:  "#3c3235"

    // ---------------------------------------------------------------------------
    // PRIMARY PALETTE
    // High-emphasis components (FABs, active buttons, switches).
    // ---------------------------------------------------------------------------

    // The main color of your app. Used for key components like the FAB or active states.
    property color primary                 :   "#ffb1c8"
    
    // Color for text and icons sitting on top of 'primary' components.
    property color on_primary              :   "#541d32"
    
    // A color variant that stays similar in both Light and Dark themes. Stronger than container.
    property color primary_fixed           :   "#ffd9e2"
    
    // Text/Icon color for content on top of 'primary_fixed'.
    property color on_primary_fixed        :   "#3a071d"

    // ---------------------------------------------------------------------------
    // SECONDARY PALETTE
    // Less prominent components (filter chips, tone-downed buttons).
    // ---------------------------------------------------------------------------

    // Used for less prominent components, like filter chips or non-active states.
    property color secondary               :   "#e3bdc6"
    
    // Color for text and icons sitting on top of 'secondary' components.
    property color on_secondary            :   "#422931"
    
    // Secondary variant that stays similar in both Light and Dark themes.
    property color secondary_fixed         :   "#ffd9e2"
    
    // Text/Icon color for content on top of 'secondary_fixed'.
    property color on_secondary_fixed      :   "#2b151c"

    // ---------------------------------------------------------------------------
    // TERTIARY PALETTE
    // Accents and contrasting elements that balance Primary/Secondary.
    // ---------------------------------------------------------------------------

    // Accent color used to break up the monotony of primary/secondary colors.
    property color tertiary                :   "#efbd94"
    
    // Color for text and icons sitting on top of 'tertiary' components.
    property color on_tertiary             :   "#48290b"
    
    // Tertiary variant that stays similar in both Light and Dark themes.
    property color tertiary_fixed          :   "#ffdcc1"
    
    // Text/Icon color for content on top of 'tertiary_fixed'.
    property color on_tertiary_fixed       :   "#2e1500"

    // ---------------------------------------------------------------------------
    // ERROR PALETTE
    // Warnings and critical alerts.
    // ---------------------------------------------------------------------------

    // Used for text or icons that indicate an error state.
    property color error                   :   "#ffb4ab"
    
    // Color for text on top of 'error' (e.g. text on a red delete button).
    property color on_error                :   "#690005"
    
    // Used for the background of error messages (e.g. a red banner).
    property color error_container         :   "#93000a"
    
    // Text color to use on top of 'error_container'.
    property color on_error_container      :   "#ffdad6"

    // ---------------------------------------------------------------------------
    // INVERSE PALETTE
    // Used for things like Snackbars or dark toolbars in a light theme.
    // ---------------------------------------------------------------------------

    // The opposite of the current theme's surface (e.g. White in Dark Mode).
    property color inverse_surface         :   "#efdfe1"
    
    // Text color on top of 'inverse_surface' (e.g. Black text on White snackbar in Dark Mode).
    property color inverse_on_surface      :   "#372e30"
    
    // Action color on top of 'inverse_surface' (e.g. "Undo" button on a snackbar).
    property color inverse_primary         :   "#8c4a60"


    // Other 

    property color background   :   "#191113"
    property color on_background:   "#efdfe1"

    property color foreground   :   "#ffb1c8"

    property color hover        :   "#e3bdc6"
    property color accent       :   "#efbd94"
    property color accent2      :   "#ffb1c8"
    property color accent3      :   "#ffb1c8"
    property color accent4      :   "#ffb1c8"

    property color bordercol    :   "#8c4a60"
}
