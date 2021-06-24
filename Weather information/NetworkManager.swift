//
//  ServiceManager.swift
//  Weather information
//
//  Created by Irina Moiseeva on 14.06.2021.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let urlYandex = "https://api.weather.yandex.ru/v2/forecast"
    let keyHeader = "X-Yandex-API-Key"
    let key = "f4d456a6-3997-4ac6-91e6-978ce04191d1"
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard let urlR = URL(string: urlYandex) else { return }
        let url = URL(string: "?lat=" + String(latitude) + "&lon="  + String(longitude), relativeTo: urlR)!
        var request = URLRequest(url: url)
        request.addValue(key, forHTTPHeaderField: keyHeader)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    guard let weather = WeatherModel(weatherData: json) else {return}
                    completion(.success(weather))
                } catch {
                    print(error)
                }
            }
        }
        .resume()
    }
    
    func getWeatherForSeachedCity(city: String, completion: @escaping (WeatherModel) -> Void) {
        getCoordinate(city: city) { (coordinate, error) in
            
            guard let coordinate = coordinate, error == nil else {return}
            
            self.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
                
                switch result {
                case .success(let weather):
                    completion(weather)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getCityWeather(cities:[String], completion: @escaping (Int, WeatherModel) -> Void) {
        
        for (index, city) in cities.enumerated() {
            getCoordinate(city: city) { (coordinate, error) in
                
                guard let coordinate = coordinate, error == nil else {return}
                
                self.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
                    
                    switch result {
                    case .success(let weather):
                        completion(index, weather)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getCoordinate(city: String, completion: @escaping(CLLocationCoordinate2D?, NSError?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                
                completion(location.coordinate, nil)
                return
            }
            if let error = error {
                print(error)
            }
            completion(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
