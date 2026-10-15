pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "./colors"
import "./layouts"

QtObject {
    id: root

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

    property int borderwidth: currentTheme.borderwidth
    property int smallradius: currentTheme.smallradius
    property int bigradius: currentTheme.bigradius
    property int barradius: config.adapter.floating ? currentTheme.barradius : 0
    property int barmargin: config.adapter.floating ? config.adapter.floatValue : 0
    property int barmarginr: Math.max(0, barmargin - 10)
    property int widgetmargin: currentTheme.widgetmargin
    property int widgetwidth: currentTheme.widgetwidth
    property bool screenCorner: config.adapter.floating ? false : currentTheme.screenCorner
    property int cornerRadius: currentTheme.cornerRadius
    property int fontsize1: currentTheme.fontsize1
    property int fontsize2: currentTheme.fontsize2
    property bool bold: currentTheme.bold
    property string barPosition: config.adapter.barposition
    property string icon: config.adapter.userIcon
    property string cityLocation: config.adapter.city

    property bool isVertical: {
        if (config.adapter.barposition === "top" || config.adapter.barposition === "bottom")
            return false;
        return true;
    }

    property QtObject currentColTheme: root[config.adapter.colors] || tokyoNight
    property QtObject currentTheme: root[config.adapter.layout] || circle

    // Load JSON Config
    property FileView config: FileView {
        path: Quickshell.shellDir + "/config/user_config.json"

        // Reloads the file automatically when it changes on disk
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            property string colors: "gruvbox"
            property string layout: "circle"
            property bool floating: true
            property real floatValue: 5
            property string barposition: "left"
            property string userIcon: "" //
            property string city: "Tokyo"
        }
    }

    // Color Themes
    property QtObject matugen: Matugen {}
    property QtObject gruvbox: Gruvbox {}
    property QtObject nord: Nord {}
    property QtObject tokyoNight: TokyoNight {}
    property QtObject windowsCol: WindowsCol {}

    // Layout Themes
    property QtObject circle: Circle {}
    property QtObject squircle: Squircle {}
    property QtObject sharp: Sharp {}
    property QtObject windows: Windows {}
}
