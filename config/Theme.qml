pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "./colors"
import "./layouts"


QtObject {
    id: root

    property color background   :   currentColTheme.background
    property color on_background:   currentColTheme.on_background
    property color foreground   :   currentColTheme.foreground
    property color hover        :   currentColTheme.hover
    property color accent       :   currentColTheme.accent
    property color accent2      :   currentColTheme.accent2
    property color accent3      :   currentColTheme.accent3
    property color accent4      :   currentColTheme.accent4
    property color bordercol    :   currentColTheme.bordercol
    property color error        :   currentColTheme.error

    property int   borderwidth  :   currentTheme.borderwidth
    property int   smallradius  :   currentTheme.smallradius
    property int   bigradius    :   currentTheme.bigradius
    property int   barradius    :   config.adapter.floating ? currentTheme.barradius : 0
    property int   barmargin    :   config.adapter.floating ? config.adapter.floatValue : 0
    property int   barmarginr   :   Math.max(0, barmargin - 10)
    property int   widgetmargin :   currentTheme.widgetmargin
    property int   widgetwidth  :   currentTheme.widgetwidth
    property bool  screenCorner :   config.adapter.floating ? false : currentTheme.screenCorner
    property int   cornerRadius :   currentTheme.cornerRadius
    property int   fontsize1    :   currentTheme.fontsize1
    property int   fontsize2    :   currentTheme.fontsize2
    property bool  bold         :   currentTheme.bold
    property string barPosition :   config.adapter.barposition
    property string icon        :   config.adapter.userIcon
    
    property bool isVertical: {
        if (config.adapter.barposition === "top" || config.adapter.barposition === "bottom") return false
        return true
    } 

    property QtObject currentColTheme:  root[config.adapter.colors] || tokyoNight
    property QtObject currentTheme: root[config.adapter.layout] || circle

    // Load JSON Config
    property FileView config: FileView {
        path: Quickshell.shellDir + "/config/user_config.json"
        
        // Reloads the file automatically when it changes on disk
        watchChanges: true 
        onFileChanged: reload()

        JsonAdapter {
            property string colors: "gruvbox"
            property string layout: "round"
            property bool floating: true 
            property real floatValue: 0
            property string barposition: "left"
            property string userIcon: "" //
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

