// shell.qml
import Quickshell
import QtQml
import QtQuick
import qs.components
import qs.widgets
import qs.config

Scope {
  Loader {
        sourceComponent: {
          if (Theme.barPosition === "bottom") return bottomComp
          if (Theme.barPosition === "top") return topComp
          if (Theme.barPosition === "left") return leftComp
          if (Theme.barPosition === "right") return rightComp
        }
    }

    Component {
        id: bottomComp
        BarBottom {} 
    }

    Component {
        id: topComp
        BarTop {}
    }

    Component {
        id: leftComp
        BarLeft {}
    }

    Component {
        id: rightComp
        BarRight {}
    }
}