pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property int total: 0
    property string days: "0"    
    property string hours: "0"
    property string minutes: "00"
    
    // Optional: A combined formatted string
    property string prettyTime: (days > 0 ? days + "d " : "") + (hours > 0 ? hours + "h " : "") + minutes + " min"

    Process {
        id: statusProc
        // Just read the raw seconds file
        command: ["cat", "/proc/uptime"]
        
        stdout: SplitParser {
            onRead: data => {
                // Output looks like: "34522.45 23423.12" // first number (total seconds)
                const totalSeconds = parseFloat(data.trim().split(" ")[0])
                
                // Calculate time components
                const d = Math.floor(totalSeconds / (60*60*24))
                const h = Math.floor((totalSeconds % (60*60*24)) / (60*60))
                const m = Math.floor((totalSeconds % (60*60)) / 60)

                // Update properties
                root.total = totalSeconds
                root.days = d.toString()
                root.hours = h.toString()
                // Pad minutes with a leading zero if needed (e.g., "05")
                root.minutes = root.hours > 0 ? m.toString().padStart(2, '0') : m.toString()
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 5 * 1000
        triggeredOnStart: true
        onTriggered: {
            if (!statusProc.running) statusProc.running = true
            //console.log(root.prettyTime)
        }
    }
}