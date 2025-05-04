# 🌦️ Weather App

A simple yet elegant Flutter application that displays real-time weather information using OpenWeatherMap's public API. It allows users to view weather data for their current location or search for weather in any city.

---

## 📱 Overview

This Flutter app provides:
- Real-time weather updates  
- Search by city functionality  
- Weather display based on GPS location  
- Clean and intuitive UI with weather-based visuals  

---

## 🚀 Features

### 🔍 Search by City
- Enter a city name to retrieve current weather  
- Graceful handling of invalid city names  

### 📍 Current Location Weather
- Uses device GPS to fetch weather data based on coordinates  
- Requires location permissions  

### 🌤️ Display Weather Information
- City name  
- Temperature and "feels like" data  
- Weather description (e.g., Sunny, Cloudy)  
- Weather icons (static or animated)  
- Optional metrics: Humidity, Wind Speed, Pressure  

### 🎨 User Interface
- Clean and modern design  
- Dynamic backgrounds based on weather condition  
- Weather-specific icons  

---

## ✨ Bonus Features (Optional/Future)
- 5-day forecast with hourly breakdown  
- Dark mode support  
- Save and view favorite cities  
- Pull-to-refresh gesture  

---



## 🔑 API Information

This app uses [OpenWeatherMap API](https://openweathermap.org/api).  
To get started:

1. Sign up and generate an API key  
2. Use this endpoint:
```
https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}&units=metric
```

3. Create a `.env` file in the project root:

```env
API_KEY=your_api_key_here
```

---

## 🛠️ Getting Started

1. **Clone the repository**
```bash
git clone https://github.com/MuhammadAbu-Bakr/Weather-App
cd Weather-App
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up `.env` file**
- Create a `.env` file in the root directory  
- Add your OpenWeatherMap API key

4. **Run the app**
```bash
flutter run
```

---

## 📷 Screenshots (Optional)



---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
