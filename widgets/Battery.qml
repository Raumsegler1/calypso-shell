import QtQuick
import Quickshell
import Quickshell.Services.UPower // <--- The magic import
import "../config"

Rectangle {
    id: root
    implicitWidth: Theme.widgetwidth
    implicitHeight: Theme.widgetwidth
    color: {
            if (root.percent <= 20) return Theme.error
            if (root.isCharging) return Theme.accent
            return Theme.accent3
        }
    radius: Theme.smallradius

    // Access the main "Display Device" (the aggregate of all batteries)
    property var battery: UPower.displayDevice

    // Helper property to check if charging
    // 1 = Charging, 4 = Fully Charged (UPower states)
    property bool isCharging: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged

    // Calculate percentage (0.0 to 1.0 -> 0 to 100)
    property int percent: Math.round(battery.percentage * 100)

    Connections {
        target: UPower.displayDevice
        
        function onStateChanged() {
            console.log("State Changed at:", new Date().toLocaleTimeString())
            // Force an update just in case
            root.isCharging = (target.state === UPowerDeviceState.Charging)
        }
    }
    Text {
        anchors.centerIn: parent
        
        text: {
            var p = root.percent
            if (root.isCharging) {
                if (p <= 10) return p + " 󰢟"
                if (p <= 20) return p + " 󰢜"
                if (p <= 30) return p + " 󰂆"
                if (p <= 40) return p + " 󰂇"
                if (p <= 50) return p + " 󰂈"
                if (p <= 60) return p + " 󰢝"
                if (p <= 70) return p + " 󰂉"
                if (p <= 80) return p + " 󰢞"
                if (p <= 90) return p + " 󰂊"
                if (p < 99)  return p + " 󰂋"
                return "󱐋"
            }
            else {
                if (p <= 10) return p + " 󰂎"
                if (p <= 20) return p + " 󰁺"
                if (p <= 30) return p + " 󰁻"
                if (p <= 40) return p + " 󰁼"
                if (p <= 50) return p + " 󰁽"
                if (p <= 60) return p + " 󰁾"
                if (p <= 70) return p + " 󰁿"
                if (p <= 80) return p + " 󰂀"
                if (p <= 90) return p + " 󰂁"
                if (p < 99)  return p + " 󰂂"
                return "󱐋"
            }
        }
        color: Theme.background
        
        font.pixelSize: {
            if (root.percent >= 99) return Theme.fontsize1
            return Theme.fontsize2
        }
        font.bold: Theme.bold
    }
}