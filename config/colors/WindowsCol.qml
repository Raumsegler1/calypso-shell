// Windows11.qml
import QtQuick

QtObject {
    // --- Surface (Backgrounds) ---
    property color surface                 : "#202020" // Mica Base
    property color surface_bright          : "#323232"
    property color surface_dim             : "#1a1a1a"
    property color on_surface              : "#ffffff"
    property color on_surface_variant      : "#a0a0a0"
    
    // --- Outlines ---
    property color outline                 : "#3F3F3F"
    property color outline_variant         : "#2b2b2b"

    // --- Surface Containers ---
    property color surface_container_lowest: "#181818"
    property color surface_container_low   : "#202020"
    property color surface_container       : "#272727"
    property color surface_container_high  : "#2c2c2c"
    property color surface_container_highest: "#323232"

    // --- Primary (The Main Blue) ---
    property color primary                 : "#60CDFF" 
    property color on_primary              : "#003355"
    property color primary_fixed           : "#005FB8"
    property color on_primary_fixed        : "#ffffff"

    // --- Secondary (Neutral Greys) ---
    property color secondary               : "#cccccc"
    property color on_secondary            : "#1a1a1a"  
    property color secondary_fixed         : "#cccccc"
    property color on_secondary_fixed      : "#1a1a1a"

    // --- Tertiary (The Distinction) ---
    property color tertiary                : "#D0BCFF" 
    property color on_tertiary             : "#381E72"
    property color tertiary_fixed          : "#EADDFF"
    property color on_tertiary_fixed       : "#21005D"

    // --- Error ---
    property color error                   : "#ffb4ab"
    property color on_error                : "#690005"
    property color error_container         : "#93000a"
    property color on_error_container      : "#ffffff"

    // --- Inverse ---
    property color inverse_surface         : "#f3f3f3"
    property color inverse_on_surface      : "#202020"
    property color inverse_primary         : "#005FB8"
}