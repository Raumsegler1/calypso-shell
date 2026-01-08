pragma Singleton
import QtQuick
import qs.config

Item {
    id: root
    // --- Output Properties ---
    property string cityName: "..."
    property double latitude: 0.0
    property double longitude: 0.0
    property string temperature: "{*.*}"
    property int weatherCode: 0
    property int isDay: 1
    property string weatherIcon: getWeatherIcon(weatherCode, isDay)
    property string weatherString: getWeatherStr(weatherCode)

    // --- Logic ---
    function update() {
        // Step 1: Get Location Coordinates
        var locReq = new XMLHttpRequest();
        locReq.open("GET", `https://geocoding-api.open-meteo.com/v1/search?name=${Theme.cityLocation}&count=1&language=en&format=json`);
        
        locReq.onreadystatechange = function() {
            if (locReq.readyState === XMLHttpRequest.DONE && locReq.status === 200) {
                var json = JSON.parse(locReq.responseText);
                if (json.results && json.results.length > 0) {
                    var result = json.results[0];
                    root.cityName = result.name;
                    root.latitude = result.latitude;
                    root.longitude = result.longitude;
                    
                    // Step 2: Get Weather using those coordinates
                    fetchWeather(root.latitude, root.longitude);
                }
            }
        }
        locReq.send();
    }

    function fetchWeather(lat, lon) {
        var weatherReq = new XMLHttpRequest();
        weatherReq.open("GET", `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m,weather_code,is_day`);
        
        weatherReq.onreadystatechange = function() {
            if (weatherReq.readyState === XMLHttpRequest.DONE && weatherReq.status === 200) {
                var json = JSON.parse(weatherReq.responseText);
                root.temperature = Math.round(json.current.temperature_2m) + "°C";
                root.weatherCode = json.current.weather_code;
                // Get the is_day value (returns 1 for day, 0 for night)
                root.isDay = json.current.is_day;
            }
        }
        weatherReq.send();
    }

    function getWeatherIcon(code, isDay) {
        var day = (isDay === undefined || isDay === 1);
        // Default to day if isDay is undefined
        switch(code) {
            case 0: // Clear sky
                return day ? "wb_sunny" : "bedtime";
                
            case 1: // Mainly clear
            case 2: // Partly cloudy
                return day ? "partly_cloudy_day" : "nights_stay";
                
            case 3: // Overcast
                return "cloud";
                
            case 45: // Fog
            case 48: // Depositing rime fog
                return "foggy";
                
            case 51: // Drizzle: Light
            case 53: // Drizzle: Moderate
            case 55: // Drizzle: Dense
                return "grain";
                
            case 61: // Rain: Slight
            case 63: // Rain: Moderate
            case 80: // Rain showers: Slight
            case 81: // Rain showers: Moderate
                return "rainy";
                
            case 65: // Rain: Heavy
            case 82: // Rain showers: Violent
                return "tsunami"; // Or "flood" - Material symbols lacks a heavy rain specific icon sometimes
                
            case 71: // Snow fall: Slight
            case 73: // Snow fall: Moderate
            case 75: // Snow fall: Heavy
            case 77: // Snow grains
            case 85: // Snow showers
            case 86: // Snow showers heavy
                return "ac_unit";
                
            case 95: // Thunderstorm: Slight or moderate
            case 96: // Thunderstorm with slight hail
            case 99: // Thunderstorm with heavy hail
                return "thunderstorm";
                
            default:
                return "question_mark";
        }
    }

    function getWeatherStr(code) {
        switch(code) {
            case 0: 
                return "clear";
            case 1: 
                return "mainly clear";
            case 2: 
                return "partly cloudy";
            case 3: 
                return "overcast";

            case 45: 
            case 48: 
                return "foggy";

            case 51: 
                return "lightly drizzling";
            case 53: 
                return "drizzling";
            case 55: 
                return "heavily drizzling";

            case 61: 
                return "lightly raining";
            case 63: 
                return "raining";
            case 80: 
                return "lightly raining"; // Showers
            case 81: 
                return "raining";         // Showers

            case 65: 
                return "heavily raining";
            case 82: 
                return "violently raining"; 

            case 71: 
                return "lightly snowing";
            case 73: 
                return "snowing";
            case 75: 
                return "heavily snowing";
            case 77: 
            case 85: 
            case 86: 
                return "snowing";

            case 95: 
            case 96: 
            case 99: 
                return "thundering";

            default:
                return "error";
        }
    }

    // Auto-update every 30 minutes
    Timer {
        interval: 15 * 60 * 1000 
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.update()
    }
}

/* Output

{
    "latitude":48.08,
    "longitude":11.82,
    "generationtime_ms":0.04661083221435547,
    "utc_offset_seconds":0,
    "timezone":"GMT",
    "timezone_abbreviation":"GMT",
    "elevation":566.0,
    "current_units":{
        "time":"iso8601",
        "interval":"seconds",
        "temperature_2m":"°C",
        "weather_code":"wmo code"
    },
    "current":{
        "time":"2026-01-07T20:30",
        "interval":900,
        "temperature_2m":-8.2,
        "weather_code":0
    }
}