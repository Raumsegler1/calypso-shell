import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.components
import qs.config

Rectangle {
    id: root
    color: "transparent"
    implicitWidth: Theme.widgetwidth
    implicitHeight: barslider.height

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

    // --- 1. THE SLIDER ---
    BarSlider {
        id: barslider
        anchors.bottom: Theme.isVertical ? parent.bottom : undefined
        anchors.right: Theme.isVertical ? undefined : parent.right
        hides: true
        isVertical: Theme.isVertical
        sliderDirectionRight: false
        Behavior on fillPercent { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        sliderfgval: {
            if (Pipewire.defaultAudioSink?.audio.muted) return Theme.accent
            return Theme.foreground
        }
        sliderbgval: {
            if (Pipewire.defaultAudioSink?.audio.muted) return Theme.accent
            return Theme.foreground
        }
        value: Pipewire.defaultAudioSink?.audio.volume ?? 0
        onMoved: (newValue) => {
            Pipewire.defaultAudioSink.audio.volume = Theme.isVertical ? (newValue) : (1 - newValue)
        }
    }

    // --- 2. THE ICON ---
    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: parent.width/4
        font.pixelSize: Theme.fontsize2
        font.bold: Theme.bold
        color: Theme.background
        text: {
            var vol = (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink?.audio.volume) || 0
            var volpercent = Math.round(Pipewire.defaultAudioSink?.audio.volume*100)

            if (Pipewire.defaultAudioSink?.audio.muted && !barslider.onSlider) return " "
            if (vol < 0.01) return " "
            if (barslider.onSlider && vol < 0.99) return volpercent
            if (vol <= 0.5 && !barslider.onSlider) return " "
            if (vol <= 0.99 && !barslider.onSlider) return "  "
            return "  "
        }
    }
}