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
                bottom: true
            }
            implicitHeight: Theme.widgetwidth + Theme.widgetmargin*2 + extraSpace
            margins { 
                top:    Theme.barmarginr - extraSpace  
                bottom: Theme.barmargin
                left:   Theme.barmargin 
                right:  Theme.barmargin
            }
            color: '#00ffffff'
            visible: true
            
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                corner: RoundCorner.CornerEnum.BottomLeft
                implicitSize: extraSpace
                color: Theme.background
            }

            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                corner: RoundCorner.CornerEnum.BottomRight
                implicitSize: extraSpace
                color: Theme.background
            }
             
            Rectangle {
                id: barShape 
                anchors { 
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                implicitHeight: Theme.widgetwidth + Theme.widgetmargin*2
                color: Theme.background
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

                    WorkspacesHorizontal { 
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