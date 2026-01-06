pragma Singleton  
import QtQuick  
import Quickshell  
import Quickshell.Io
import Quickshell.Services.Mpris  
  

// Breaks when using Youtube Autoplay without browserfix
// fix: https://addons.mozilla.org/en-US/firefox/addon/youtube-mpris-fix/
Item {  
    id: root  

    readonly property var isConnected: player ? true : false
      
    readonly property MprisPlayer player: {  
        const playing = Mpris.players.values.find(p => p.isPlaying === true)  
        if (playing) return playing  
        if (trackedPlayer) return trackedPlayer  
        if (Mpris.players.values.length > 0) return Mpris.players.values[0]  
        return null  
    }  
      
    property MprisPlayer trackedPlayer: null  

    onPlayerChanged: {
        if (player) {
            trackedPlayer = player
        }
    }

    FrameAnimation {
      // only emit the signal when the position is actually changing.
      running: player?.isPlaying == true
      onTriggered: player.positionChanged()
    }
      
    // Properties with safety  
    readonly property var identity: player?.identity || ""  
    readonly property bool canTogglePlaying: player?.canTogglePlaying || false  
    readonly property bool lengthSupported: player?.lengthSupported || false  
    readonly property bool positionSupported: player?.positionSupported || false  
    readonly property bool canSeek: player?.canSeek || false  
    readonly property bool canGoNext: player?.canGoNext || false  
    readonly property bool canGoPrevious: player?.canGoPrevious || false  
    readonly property bool loopSupported: player?.loopSupported || false
    readonly property bool shuffleSupported: player?.shuffleSupported || false


      
    readonly property var trackAlbum: player?.trackAlbum || "Unknown Album"  
    readonly property var trackAlbumArtist: player?.trackAlbumArtist || "Unknown Album"  
    readonly property var trackArtist: player?.trackArtist || "Unknown Artist"  
    readonly property var trackTitle: player?.trackTitle || "Unknown Title"  
    readonly property var trackArtUrl: player?.trackArtUrl || ""  
      
    readonly property var maxRate: player?.maxRate || 1.0  
    readonly property var minRate: player?.minRate || 1.0  
    readonly property var length: player?.length || 0 

    readonly property string prettyPosition: {
      const val = position || 0
      const m = Math.floor(val / 60)
      const s = Math.floor(val % 60)
      return `${m}:${s.toString().padStart(2, '0')}`
    }

    readonly property string prettyLength: {
      const val = length || 0
      const m = Math.floor(val / 60)
      const s = Math.floor(val % 60)
      return `${m}:${s.toString().padStart(2, '0')}`
    }

    readonly property string prettyRemainder: {
      const val = (length - position) || 0
      const m = Math.floor(val / 60)
      const s = Math.floor(val % 60)
      return `${m}:${s.toString().padStart(2, '0')}`
    }

    // editable options
    property bool shuffle: player?.shuffle || false  
    property var loopState: player?.loopState || "None" // None || Track ||  Playlist
    property var position: player?.position || 0  
    property var isPlaying: player?.isPlaying || false  
    property var rate: player?.rate || 1.0  

    /* 
    // Lyrics currently from: https://github.com/SolarPunchGames/Kriti-shell/blob/main/Services/Players.qml
  signal lyricsChanged()

  Connections {  
    target: player  
    function onPostTrackChanged() {
      reloadLyrics() 
    }  
  }
  
  function reloadLyrics() {
    lyricsTimer.running = false
    lyricsTimer.running = true
    lyricsProc.running = false
    defaultLyrics = 1
    currentTry = 1

    lyricsChanged()
  }

  property var trackLyrics: defaultLyrics
  property var defaultLyrics: 1

  readonly property int maxTries: 5
  property int currentTry: 1

  Timer {
    id: lyricsTimer
    interval: 100
    running: {
      console.log("https://lrclib.net/api/get?artist_name=" + encodeURI(trackArtist) + "&track_name=" + encodeURI(trackTitle) + "&album_name=" + encodeURI(trackAlbum) + "&duration=" + length)
      true
    }
    onTriggered: {
      lyricsProc.running = true
    }
  }

  Process {
        id: lyricsProc
        running: false
        command: [ "curl", "https://lrclib.net/api/get?artist_name=" + encodeURI(player.trackArtist) + "&track_name=" + encodeURI(player.trackTitle) + "&album_name=" + encodeURI(player.trackAlbum) + "&duration=" + player.length]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: {
                //console.log(text)
                if (JSON.parse(text).statusCode) {
                if (currentTry < maxTries) {
                    lyricsTimer.running = true
                    currentTry += 1
                } else {
                    defaultLyrics = 404
                }
                console.log("lyrics failed")
                } else {
                    //defaultLyrics = JSON.parse(text)
                }
            }
        }
    }*/
}

/*

Functions of player
seek(offset) offsets position by offset useful for e.g. skipping 5s 
togglePlaying() toggles State
next()
previous()
