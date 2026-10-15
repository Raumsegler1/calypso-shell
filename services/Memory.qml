pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    property int maxRam: 0
    property int usedRam: 0
    readonly property real maxRamGb: (maxRam / 1048576).toFixed(1)
    readonly property real usedRamGb: (usedRam / 1048576).toFixed(1)
    readonly property real usedRamRelative: (usedRam / maxRam).toFixed(2)
    readonly property real usedRamPercentage: Math.round((usedRam / maxRam) * 100)

    Process {
        id: statusProc
        command: ["sh", "-c", "free | grep Mem:"]

        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/);
                maxRam = parts[1];
                usedRam = parts[2];
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: statusProc.running = true
        triggeredOnStart: true
    }
}

// command output
// Mem:        31949468     4352360    22836564      101604     5069736    27597108
//              (maxRam)    (usedRam)                                        (freeRam)
