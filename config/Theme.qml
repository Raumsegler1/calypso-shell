// =============================================================================
// Theme.qml: central theme singleton for calypso-shell
//
// Every widget reads its colors, sizes and fonts from here (Theme.primary,
// Theme.widgetwidth, ...). Nothing else in the shell hardcodes styling.
//
// HOW A THEME IS RESOLVED
//   There are two independent theme "axes", each picked by name in
//   ~/.config/calypso-shell/user_config.json:
//
//     "colors" -> a color palette  (Gruvbox.qml, Nord.qml, ...)
//     "layout" -> sizes/radii/fonts (Circle.qml, Squircle.qml, ...)
//
//   For each axis the lookup order is:
//     1. a USER file:  ~/.config/calypso-shell/colors/<name>.qml
//                      ~/.config/calypso-shell/layouts/<name>.qml
//     2. a BUILT-IN theme shipped with the shell (config/colors, config/layouts)
//     3. a hardcoded default (TokyoNight / Circle) if the name is unknown
//
//   User theme files must be COMPLETE: copy a built-in file, rename it, edit
//   the values. A missing key is simply undefined (no per-key fallback).
//
// FILE MAP
//   currentColTheme / currentTheme  -> the object the properties below read from
//   config (FileView)               -> user_config.json (live-reloaded)
//   colorFile / layoutFile          -> watch + load the user theme files
// =============================================================================
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "./colors"
import "./layouts"

QtObject {
    id: root

    // -------------------------------------------------------------------------
    // COLOR ROLES
    // Material Design 3 role names. Each one just forwards to whichever color
    // theme object is currently active (see currentColTheme further down), so
    // switching themes updates every binding automatically.
    // -------------------------------------------------------------------------

    // --- Surface ---
    property color surface: currentColTheme.surface
    property color surface_bright: currentColTheme.surface_bright
    property color on_surface: currentColTheme.on_surface
    property color outline: currentColTheme.outline
    property color outline_variant: currentColTheme.outline_variant

    // --- Surface Container ---
    property color surface_container_lowest: currentColTheme.surface_container_lowest
    property color surface_container_low: currentColTheme.surface_container_low
    property color surface_container: currentColTheme.surface_container
    property color surface_container_high: currentColTheme.surface_container_high
    property color surface_container_highest: currentColTheme.surface_container_highest

    // --- Primary (Fixed) ---
    property color primary: currentColTheme.primary
    property color on_primary: currentColTheme.on_primary
    property color primary_fixed: currentColTheme.primary_fixed
    property color on_primary_fixed: currentColTheme.on_primary_fixed

    // --- Secondary (Fixed) ---
    property color secondary: currentColTheme.secondary
    property color on_secondary: currentColTheme.on_secondary
    property color secondary_fixed: currentColTheme.secondary_fixed
    property color on_secondary_fixed: currentColTheme.on_secondary_fixed

    // --- Tertiary (Fixed) ---
    property color tertiary: currentColTheme.tertiary
    property color on_tertiary: currentColTheme.on_tertiary
    property color tertiary_fixed: currentColTheme.tertiary_fixed
    property color on_tertiary_fixed: currentColTheme.on_tertiary_fixed

    // --- Error (Container) ---
    property color error: currentColTheme.error
    property color on_error: currentColTheme.on_error
    property color error_container: currentColTheme.error_container
    property color on_error_container: currentColTheme.on_error_container

    // --- Inverse ---
    property color inverse_surface: currentColTheme.inverse_surface
    property color inverse_on_surface: currentColTheme.inverse_on_surface
    property color inverse_primary: currentColTheme.inverse_primary

    // -------------------------------------------------------------------------
    // LAYOUT VALUES
    // Sizes, radii and fonts. Most come from the active layout theme
    // (currentTheme); a few are combined with user_config.json settings.
    // -------------------------------------------------------------------------
    property int borderwidth: currentTheme.borderwidth
    property int smallradius: currentTheme.smallradius
    property int bigradius: currentTheme.bigradius

    // Bar corner radius: only rounded when the bar is "floating" (detached
    // from the screen edge), otherwise flush with the screen so radius is 0.
    property int barradius: config.adapter.floating ? currentTheme.barradius : 0

    // Gap between the bar and the screen edge (only when floating).
    property int barmargin: config.adapter.floating ? config.adapter.floatValue : 0

    // Reduced margin for the side of the bar that faces the desktop.
    // Never negative.
    property int barmarginr: Math.max(0, barmargin - 10)

    property int widgetmargin: currentTheme.widgetmargin
    property int widgetwidth: currentTheme.widgetwidth

    // Rounded screen corners are only drawn when NOT floating (a floating bar
    // already has its own rounded shape).
    property bool screenCorner: config.adapter.floating ? false : currentTheme.screenCorner

    property int cornerRadius: currentTheme.cornerRadius
    property int fontsize1: currentTheme.fontsize1
    property int fontsize2: currentTheme.fontsize2
    property bool bold: currentTheme.bold

    // -------------------------------------------------------------------------
    // SETTINGS FORWARDED FROM user_config.json
    // -------------------------------------------------------------------------
    property string barPosition: config.adapter.barposition  // "top" | "bottom" | "left" | "right"
    property string icon: config.adapter.userIcon            // glyph shown in the User widget
    property string cityLocation: config.adapter.city        // used by the Weather service

    // True for left/right bars. Widgets use this to switch between row and
    // column layouts.
    property bool isVertical: {
        if (config.adapter.barposition === "top" || config.adapter.barposition === "bottom")
            return false;
        return true;
    }

    // -------------------------------------------------------------------------
    // BUILT-IN THEME LOOKUP
    // Maps the name from user_config.json to one of the built-in theme objects
    // declared further down. Done in functions (not a lookup table) so the
    // objects are read when the binding runs, after they have been created.
    // To add a built-in theme: create the .qml file, declare it below under
    // "Color Themes" / "Layout Themes", and add a case here.
    // Unknown names fall back to TokyoNight (colors) / Circle (layouts).
    // -------------------------------------------------------------------------
    function builtinColor(name) {
        switch (name) {
        case "gruvbox":
            return gruvbox;
        case "nord":
            return nord;
        case "tokyoNight":
            return tokyoNight;
        case "windowsCol":
            return windowsCol;
        default:
            return tokyoNight;
        }
    }

    function builtinLayout(name) {
        switch (name) {
        case "circle":
            return circle;
        case "squircle":
            return squircle;
        case "sharp":
            return sharp;
        case "windows":
            return windows;
        default:
            return circle;
        }
    }

    // The theme objects everything above reads from.
    // "??" means: use the user's theme if one is loaded (non-null), otherwise
    // use the built-in. This is the single place where user themes win.
    property QtObject currentColTheme: userColTheme ?? builtinColor(config.adapter.colors)
    property QtObject currentTheme: userLayoutTheme ?? builtinLayout(config.adapter.layout)

    // -------------------------------------------------------------------------
    // USER CONFIG (~/.config/calypso-shell/user_config.json)
    // The values inside JsonAdapter are DEFAULTS, used when the file is missing
    // or lacks a key. Edits to the file are picked up live via watchChanges.
    // -------------------------------------------------------------------------
    property FileView config: FileView {
        path: configDir + "user_config.json"

        // Reloads the file automatically when it changes on disk
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            property string colors: "gruvbox"   // color theme name (built-in or user file)
            property string layout: "circle"    // layout theme name (built-in or user file)
            property bool floating: true        // detached, rounded bar vs. flush bar
            property real floatValue: 5         // gap to the screen edge when floating
            property string barposition: "left" // top | bottom | left | right
            property string userIcon: "" //
            property string city: "Tokyo"       // weather location
        }
    }

    // -------------------------------------------------------------------------
    // BUILT-IN THEMES
    // One instance of each theme file in config/colors and config/layouts.
    // They only hold values; nothing is shown. Keep in sync with
    // builtinColor() / builtinLayout() above.
    // -------------------------------------------------------------------------

    // Color Themes
    property QtObject gruvbox: Gruvbox {}
    property QtObject nord: Nord {}
    property QtObject tokyoNight: TokyoNight {}
    property QtObject windowsCol: WindowsCol {}

    // Layout Themes
    property QtObject circle: Circle {}
    property QtObject squircle: Squircle {}
    property QtObject sharp: Sharp {}
    property QtObject windows: Windows {}

    // -------------------------------------------------------------------------
    // PER-USER PATHS
    // configDir ends with a trailing slash, so append names directly
    // ("colors/...", "user_config.json").
    // -------------------------------------------------------------------------
    readonly property string configDir: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/calypso-shell/"
    readonly property string userName: Quickshell.env("USER")
    // NOTE: configDir already ends in "/", so this produces "...//.face".
    // Harmless on Linux, but could be tidied to  configDir + ".face".
    readonly property string faceUrl: "file://" + configDir + "/.face"

    // -------------------------------------------------------------------------
    // USER THEME LOADING
    // A user theme is a normal QML file, loaded at runtime with
    // Qt.createComponent(). userColTheme / userLayoutTheme hold the loaded
    // object, or null when no user file exists for the selected name.
    // -------------------------------------------------------------------------

    // Bumped on every (re)load and appended to the URL as "?v=N" so Qt does
    // not serve an old cached copy after the file was edited.
    property int themeRev: 0
    property QtObject userColTheme: null
    property QtObject userLayoutTheme: null

    // kind = "colors" or "layouts", name = file name without ".qml".
    // Returns the created object, or null if the file failed to compile
    // (the error is logged, and the built-in theme is used instead).
    function loadUserTheme(kind, name) {
        const url = "file://" + configDir + kind + "/" + name + ".qml?v=" + themeRev;
        const comp = Qt.createComponent(url);
        if (comp.status === Component.Ready)
            return comp.createObject(root);
        console.warn("calypso: could not load", kind, name, comp.errorString());
        return null;
    }

    // Watches ~/.config/calypso-shell/colors/<selected name>.qml.
    // The FileView is only used to detect that the file exists / changed;
    // the QML itself is loaded by loadUserTheme().
    property FileView colorFile: FileView {
        path: root.configDir + "colors/" + root.config.adapter.colors + ".qml"
        watchChanges: true
        onFileChanged: reload()

        // File exists: (re)load it, then destroy the previous instance.
        onLoaded: {
            root.themeRev++;
            const old = root.userColTheme;
            root.userColTheme = root.loadUserTheme("colors", root.config.adapter.colors);
            if (old)
                old.destroy();
        }

        // No such file (the normal case for built-in themes): clear the user
        // theme so currentColTheme falls back to the built-in one.
        // The old object is detached BEFORE destroy() so nothing reads it
        // while it is being deleted.
        onLoadFailed: {
            const old = root.userColTheme;     // userLayoutTheme in layoutFile
            root.userColTheme = null;
            if (old)
                old.destroy();
        }
    }

    // Same as colorFile, but for ~/.config/calypso-shell/layouts/<name>.qml.
    property FileView layoutFile: FileView {
        path: root.configDir + "layouts/" + root.config.adapter.layout + ".qml"
        watchChanges: true
        onFileChanged: reload()

        onLoaded: {
            root.themeRev++;
            const old = root.userLayoutTheme;
            root.userLayoutTheme = root.loadUserTheme("layouts", root.config.adapter.layout);
            if (old)
                old.destroy();
        }

        // As written, a missing layout file (e.g. when using a built-in
        // layout) also wipes the loaded USER COLOR theme.
        onLoadFailed: {
            const old = root.userLayoutTheme;
            root.userLayoutTheme = null;
            if (old)
                old.destroy();
        }
    }
}
