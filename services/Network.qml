pragma Singleton 

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    
    // --- PUBLIC API ---
    property bool isWifi: false
    property bool isEthernet: false
    property bool isConnected: false
    property int strength: 0
    property string ssid: "Disconnected"
    
    property int downloadSpeed: 0
    property int uploadSpeed: 0

    readonly property string formatDownloadSpeed: formatSpeed(downloadSpeed)
    readonly property string formatUploadSpeed: formatSpeed(uploadSpeed)
    
    // --- INTERNAL STATE ---
    property string activeDevice: "" 
    property var _lastRx: 0
    property var _lastTx: 0
    
    // BUFFER: Store the text here until the command finishes
    property string _statusBuffer: ""

    // --- 1. CONNECTION STATUS ---
    Process {
        id: statusProc
        command: ["nmcli", "-t", "-f", "DEVICE,TYPE,STATE", "d", "status"]
        
        // 1. Collect data line-by-line into the buffer
        stdout: SplitParser {
            onRead: (data) => root._statusBuffer += data + "\n"
        }

        // 2. When command finishes, parse the WHOLE buffer at once
        onExited: (code) => {
            if (code === 0) root.parseStatus(root._statusBuffer)
            root._statusBuffer = "" // Clean up for next time
        }
    }

    Timer {
        interval: 5000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: statusProc.running = true
    }

    // --- 2. WIFI STRENGTH ---
    Process {
        id: wifiProc
        command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL,SSID device wifi | grep '*'"]
        stdout: SplitParser {
            onRead: (data) => root.parseWifi(data)
        }
    }

    Timer {
        interval: 5000; running: root.isWifi; repeat: true
        onTriggered: wifiProc.running = true
    }

    // --- 3. TRAFFIC / SPEED ---
    Process {
        id: trafficProc
        command: ["cat", "/proc/net/dev"]
        stdout: SplitParser {
            onRead: (data) => root.parseTraffic(data)
        }
    }

    Timer {
        interval: 1000; running: root.isConnected; repeat: true
        onTriggered: trafficProc.running = true
    }

    // --- PARSING LOGIC ---

    function parseStatus(data) {
        var lines = data.split("\n")
        
        var foundWifi = false
        var foundEth = false
        var device = ""

        for (var i = 0; i < lines.length; i++) {
            var line = lines[i].trim()
            if (!line) continue

            var parts = line.split(":") 
            if (parts.length < 3) continue

            var devName = parts[0]
            var type = parts[1]
            var state = parts[2]

            // Skip garbage devices
            if (devName === "lo") continue
            if (devName.startsWith("p2p-")) continue

            if (state.includes("connected")) {
                if (type.includes("wifi") || type.includes("wireless")) {
                    foundWifi = true
                    device = devName
                    break // Stop looking, we found the best one!
                }
                if (type.includes("ethernet")) {
                    foundEth = true
                    device = devName
                    break // Stop looking!
                }
            }
        }

        root.activeDevice = device
        root.isWifi = foundWifi
        root.isEthernet = foundEth
        root.isConnected = foundWifi || foundEth
        
        if (foundWifi) wifiProc.running = true
        
        // Debugging
        // console.log("Parsed Device:", root.activeDevice, "| Status:", root.isConnected)
    }

    function parseWifi(data) {
        var parts = data.trim().split(/\s+/)
        if (parts.length >= 3) {
            root.strength = parseInt(parts[1])
            root.ssid = parts.slice(2).join(" ")
        }
    }

    function parseTraffic(data) {
        if (root.activeDevice === "") return

        var lines = data.split("\n")
        for (var i = 0; i < lines.length; i++) {
            var line = lines[i].trim()
            if (line.startsWith(root.activeDevice + ":")) {
                
                var raw = line.substring(line.indexOf(":") + 1).trim()
                var parts = raw.split(/\s+/)
                
                var currentRx = parseInt(parts[0])
                var currentTx = parseInt(parts[8])

                if (root._lastRx > 0) root.downloadSpeed = currentRx - root._lastRx
                if (root._lastTx > 0) root.uploadSpeed = currentTx - root._lastTx

                root._lastRx = currentRx
                root._lastTx = currentTx
                return
            }
        }
    }

    function formatSpeed(bytes) {
        if (bytes > 1024 * 1024) return (bytes / 1024 / 1024).toFixed(1) + " MB/s"
        if (bytes > 1024) return (bytes / 1024).toFixed(0) + " KB/s"
        return bytes + " B/s"
    }
}