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
                right: true
                top: true
            }
            implicitHeight: Theme.widgetwidth + Theme.widgetmargin*2 + extraSpace
            margins { 
                top:    Theme.barmargin
                bottom: Theme.barmarginr - extraSpace  
                left:   Theme.barmargin 
                right:  Theme.barmargin
            }
            color: '#00ffffff'
            visible: true
            
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                corner: RoundCorner.CornerEnum.TopLeft
                implicitSize: extraSpace
                color: Theme.surface
            }

            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                corner: RoundCorner.CornerEnum.TopRight
                implicitSize: extraSpace
                color: Theme.surface
            }
             
            Rectangle {
                id: barShape 
                anchors { 
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                implicitHeight: Theme.widgetwidth + Theme.widgetmargin*2
                color: Theme.surface
                radius: Theme.barradius
                visible: true

                GridLayout {
                    id: center
                    anchors.centerIn: parent    
                    anchors.margins: Theme.widgetmargin
                    columnSpacing: Theme.widgetmargin
                    rows: 1
                    Clock {
                        id: clock
                    }
                }

                GridLayout { 
                    id: top   
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter 
                    anchors.margins: Theme.widgetmargin
                    columnSpacing: Theme.widgetmargin
                    rows: 1

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
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter 
                    anchors.margins: Theme.widgetmargin
                    columnSpacing: Theme.widgetmargin
                    rows: 1
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