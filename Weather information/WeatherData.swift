//
//  WeatherDat.swift
//  Weather information
//
//  Created by Irina Moiseeva on 22.06.2021.
//

import Foundation

struct WeatherData: Decodable {
    let fact: Fact
    let forecasts: [Forecast]
    let info: Info
}

struct Info: Codable {
    let lat: Double
    let lon: Double
    let tzinfo: Tzinfo
}

struct Tzinfo: Codable {
    let name: String
}

struct Forecast: Decodable  {
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
    let evening: Evening
}

struct Day: Codable {
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
}

struct Evening: Codable {
    
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
}

struct Fact: Codable {
     let temp: Int
     let feels_like: Int
     let pressure_mm: Int
     let humidity: Int
     let condition: String
    let icon: String
}

