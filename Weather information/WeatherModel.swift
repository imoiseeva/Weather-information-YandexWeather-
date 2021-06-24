//
//  WeatherMod.swift
//  Weather information
//
//  Created by Irina Moiseeva on 22.06.2021.
//

import Foundation

struct WeatherModel {
    var cityName: String = ""
    var temperature: Int = 0
    var temperatureNight: Int = 0
    var condition: String = ""
    
    init?(weatherData: WeatherData) {
        cityName = weatherData.info.tzinfo.name
        temperature = Int(weatherData.fact.temp)
        condition = weatherData.fact.icon
        temperatureNight = Int(weatherData.forecasts.first!.parts.evening.tempMax)
        condition = weatherData.fact.condition

    }

    var conditionName: String {
        
        switch condition {
        case "clear":
            return "sun.min"
        case "partly-cloudy":
            return "cloud.sun"
        case "cloudy":
            return "cloud.sun"
        case "overcast":
            return "cloud"
        case "drizzle":
            return "cloud.drizzle"
        case "light-rain":
            return "cloud.rain"
        case "rain":
            return "cluod.rain"
        case "moderate-rain":
            return "cluod.rain"
        case "heavy-rain":
            return "cloud.heavyrain"
        case "continuous-heavy-rain":
            return "cloud.heavyrain"
        case "showers":
            return "cloud.heavyrain"
        case "wet-snow":
            return "cloud.sleet"
        case "light-snow":
            return "cloud.snow"
        case "snow":
            return "cloud.snow"
        case "snow-showers":
            return "cloud.snow"
        case "hail":
            return "cloud.hail"
        case "thunderstorm":
            return "cloud.bolt.rain"
        case "thunderstorm-with-rain":
            return "cloud.bolt.rain"
        case "thunderstorm-with-hail":
            return "cloud.bolt.rain"
        default:
            return "cloudy"
        }
    }

    init() {}
}
