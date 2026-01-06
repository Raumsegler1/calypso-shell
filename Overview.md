Goal: Make a simple, powerful, extensible and modular shell in quickshell for Hyprland, while learning as much as possible and doing as much myself as possible

SubGoals:

IPC (Inter-Process Communication)
Service Isolation
Dynamic theming via Matugen
Extensive user customization

Structure Overview:

shell.qml

config/: default settings & user settings

components/: basic UI building blocks

widgets/: complex standalone components with logic

services/: "backend" logic; scripts

assets/: images, fonts, svgs

FEATURES:
- Powerwidget with PopupSettings
- Workspacewidget with icons for Apps and scrollable
- Mediawidget with Popup for bigger Cover and media controls
- Clock basic no Popup yet
- Userwidget missing userCenter popup
- Audioslider that expands and switches color based on mute state
- Cpu & Ram usage Widgets no popups
- Network widget with network strength and popup for down- and uploadspeed
- Batterywidget showing how full it is with icons and number adapts to low battery and if charging. missing popup for time until full/empty estimates and battery health
- Theme system for Layout and Color missing User Menu

TODO:
- Usersettings Menu
- UserCenter Popup
    - Uptime
    - UserIcon
    - Weather
    - SettingsIcon
    - DiskUsage GpuUsage CpuUsage RamUsage
    - Time until Empty/Full
    - Date & Location
    - Bluetooth and Network manager to search for and connect to devices
- Calendar Popup showing Date and Calendar with Special Days
- Media Popup
    - Lyrics
    - Visualizer
- Battery Popup
    - Time until Empty/Full
    - Battery health
- more Network Stats
    - polling max UP/DOWNloadspeed every 30-60min and saving
    - showing Graph of speed
- Bluetoothwidget to see connection status with Popup
    - connected device
- Making The bar rotation agnostic
- disconnecting floating from layout and have it be a seperate option with slider for value
- different values for horizontal and vertical bar margins
- volume Mixer

Required:
- better service for battery to also estimate time untill full and battery health
- better service for media to get all players and adjust all their values
- change how thing are laid out based on a Vertical setting in Theme
- pull floating values out of layout and into user_setting
- improve network service to querry max network speed and save it
- improve network service so it allows for displaying and choosing all networks with password input
- a service for calendar and special days
- a service for weather
- a service for location
- a service for GpuUsage
- a service for DiskUsage
- a service for bluetooth managment

