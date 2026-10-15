import QtQuick
import qs.config

Item {
    id: root

    // --- API ---
    // 1. The Popup file to load (e.g. Qt.resolvedUrl("../widgets/NetworkWindow.qml"))
    property string popupSource: ""

    // 3. State (Use this to color your button: if (handler.pinned) ...)
    property bool pinned: false
    property bool hovered: false

    // 4. Customization
    property bool pinnable: false

    // Fill the button so we catch all clicks/hovers
    anchors.fill: parent

    // --- INTERNAL ---
    property var _popupComponent: null
    property var _popupWindow: null

    Binding {
        target: _popupWindow
        property: "pinned"
        value: root.pinned
        when: _popupWindow !== null
    }

    Connections {
        target: _popupWindow
        // The 'ignoreUnknownSignals' is useful since _popupWindow might be null/changing
        ignoreUnknownSignals: true

        function onPinnedChanged() {
            // Only update if they are different to avoid loops
            if (root.pinned !== _popupWindow.pinned) {
                root.pinned = _popupWindow.pinned;
            }
        }
    }

    onPinnedChanged: {
    if (!pinned && _popupWindow && _popupWindow.visible) closeTimer.restart()
}

    // 1. Mouse Click (Pin / Unpin)
    TapHandler {
        onTapped: {
            if (pinnable) {
                root.pinned = !root.pinned;
                if (root.pinned) {
                    closeTimer.stop();
                    root.showPopup();
                } else {
                    if (root._popupWindow && root._popupWindow.visible) {
                        root._popupWindow.closeAnimated();
                    }
                }
            }
        }
    }

    // 2. Hover (Peek)
    HoverHandler {
        id: mouse
        onHoveredChanged: {
            root.hovered = mouse.hovered;
            if (root.pinned)
                return;
            if (hovered) {
                closeTimer.stop();
                if (!root._popupWindow || !root._popupWindow.visible) {
                    root.showPopup();
                }
            } else {
                closeTimer.start();
            }
        }
    }

    Timer {
    id: closeTimer
    interval: 250
    onTriggered: {
        if (!root._popupWindow) return
        if (root.pinned) return

        // Mouse is inside the popup: check again shortly
        if (root._popupWindow.isHovered) { restart(); return }

        // Mouse is back on the button: keep it open
        if (mouse.hovered) return

        if (root._popupWindow.visible) root._popupWindow.closeAnimated()
    }
}

    // 4. Logic
    function showPopup() {
        if (!_popupComponent)
            _popupComponent = Qt.createComponent(root.popupSource);

        if (_popupComponent.status === Component.Error) {
            console.error("PopupHandler Error: " + _popupComponent.errorString());
            return;
        }

        if (!_popupWindow) {
            if (_popupComponent.status === Component.Ready) {
                _popupWindow = _popupComponent.createObject(root);
                _popupWindow.anchor.item = parent; // anchor Popup to Widget
            } else {
                return;
            }
        }

        _popupWindow.visible = true;
    }
}
