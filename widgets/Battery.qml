import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.config

Rectangle {
    id: root
    implicitWidth: Theme.widgetwidth
    implicitHeight: Theme.widgetwidth
    color: {
        if (root.percent <= 20)
            return Theme.error_container;
        if (root.isCharging)
            return Theme.tertiary;
        return Theme.primary;
    }
    radius: Theme.smallradius

    // Access the main "Display Device" (the aggregate of all batteries)
    property var battery: UPower.displayDevice
    visible: battery.isPresent

    // Helper property to check if charging
    // 1 = Charging, 4 = Fully Charged (UPower states)
    property bool isCharging: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged

    // Calculate percentage (0.0 to 1.0 -> 0 to 100)
    property int percent: Math.round(battery.percentage * 100)

    Text {
        anchors.centerIn: parent

        text: {
            var p = root.percent;
            if (root.isCharging) {
                if (p <= 10)
                    return p + " 󰢟";
                if (p <= 20)
                    return p + " 󰢜";
                if (p <= 30)
                    return p + " 󰂆";
                if (p <= 40)
                    return p + " 󰂇";
                if (p <= 50)
                    return p + " 󰂈";
                if (p <= 60)
                    return p + " 󰢝";
                if (p <= 70)
                    return p + " 󰂉";
                if (p <= 80)
                    return p + " 󰢞";
                if (p <= 90)
                    return p + " 󰂊";
                if (p < 99)
                    return p + " 󰂋";
                return "󱐋";
            } else {
                if (p <= 10)
                    return p + " 󰂎";
                if (p <= 20)
                    return p + " 󰁺";
                if (p <= 30)
                    return p + " 󰁻";
                if (p <= 40)
                    return p + " 󰁼";
                if (p <= 50)
                    return p + " 󰁽";
                if (p <= 60)
                    return p + " 󰁾";
                if (p <= 70)
                    return p + " 󰁿";
                if (p <= 80)
                    return p + " 󰂀";
                if (p <= 90)
                    return p + " 󰂁";
                if (p < 99)
                    return p + " 󰂂";
                return "󱐋";
            }
        }
        color: {
            if (root.percent <= 20)
                return Theme.on_error_container;
            if (root.isCharging)
                return Theme.on_tertiary;
            return Theme.on_primary;
        }

        font.pixelSize: {
            if (root.percent >= 99)
                return Theme.fontsize1;
            return Theme.fontsize2;
        }
        font.bold: Theme.bold
    }
}
