pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    property var cpuTemp: []
    property var cpuTotal: 0 
    property var cpuIdle: 0
    readonly property var cpuTotalBusy: cpuTotal - cpuIdle
    readonly property var cpuPercentage: Math.round((cpuTotalBusy/cpuTotal) * 100)

    Process {
        id: statusProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                var currentTotal = 0
                var currentIdle = 0
                var cpuNow = data.trim().split(/\s+/)
                for (var i = 1; i < (cpuNow.length - 2); i++) {

                    var valOld = parseInt(cpuTemp[i])
                    var valNow = parseInt(cpuNow[i])

                    var diff =   valNow - valOld

                    currentTotal += diff

                    if (i === 4) {
                        currentIdle = diff
                    }
                }
                cpuTotal = currentTotal
                cpuIdle = currentIdle

                cpuTemp = cpuNow
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: statusProc.running = true
    }
}

// command output
// cpu  78268 2049 31085 6872684 2134 18426 3264 0 0 0
//