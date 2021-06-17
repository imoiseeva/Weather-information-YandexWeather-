//
//  WeatherModel.swift
//  WeatherData information
//
//  Created by Irina Moiseeva on 15.06.2021.
//

import Foundation

struct WeatherModel {
    var cityName: String = ""
    var temperature: Int = 0
    var temperatureNight: Int = 0
    var condition: String = ""
    
    var citiesArray = [
        "Moscow",
        "London",
        "NewYork",
        "Melburn",
        "Honkong",
        "Paris",
        "Berlin",
        "Tallinn",
        "Vilnius",
        "Helsinki"
    ]
    
    var conditionName: String {
        
        switch conditionName {
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
            return "cluod.rain"
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
 
}
