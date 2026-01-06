import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.widgets
import qs.components
import qs.services

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: mainBar
            required property var modelData
            screen: modelData

            property int extraSpace: Theme.screenCorner ? Theme.cornerRadius : 0
            anchors { 
                left: true
                top: true
                bottom: true
            }
            implicitWidth: Theme.widgetwidth + Theme.widgetmargin*2 + extraSpace
            margins { 
                top:    Theme.barmargin 
                bottom: Theme.barmargin 
                left:   Theme.barmargin 
                right:  Theme.barmarginr - extraSpace
            }
            color: '#00ffffff'
            visible: true
            
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                corner: RoundCorner.CornerEnum.TopLeft
                implicitSize: extraSpace
                color: Theme.background
            }

            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                corner: RoundCorner.CornerEnum.BottomLeft
                implicitSize: extraSpace
                color: Theme.background
            }
             
            Rectangle {
                id: barShape 
                anchors { 
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                implicitWidth: Theme.widgetwidth + Theme.widgetmargin*2
                color: Theme.surface
                radius: Theme.barradius
                visible: true

                GridLayout {
                    id: center
                    anchors.centerIn: parent    
                    anchors.margins: Theme.widgetmargin
                    rowSpacing: Theme.widgetmargin
                    columns: 1
                    Clock {
                        id: clock
                    }
                }

                GridLayout { 
                    id: top   
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter 
                    anchors.margins: Theme.widgetmargin
                    rowSpacing: Theme.widgetmargin
                    columns: 1

                    User {
                        id: user
                        bar: barShape
                    } 

                    WorkspacesVertical { 
                        id: workspaces
                    } // Workspaces with decoraction // Workspaces2 without

                    MediaWidget {
                        id: media
                    }  
                }

                GridLayout {
                    id: bottom
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter 
                    anchors.margins: Theme.widgetmargin
                    rowSpacing: Theme.widgetmargin
                    columns: 1
                    Volume {
                        id: volume
                    }

                    CpuWidget {
                        id: cpu
                    }

                    MemoryWidget {
                        id: ram
                    }

                    NetworkWidget {
                        id: network
                    }

                    Battery{
                        id: battery
                    }

                    Power {
                        id: power 
                        bar: barShape
                    }
                }
            }
        }
    }
}