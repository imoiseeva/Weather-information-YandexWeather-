//
//  ServiceManager.swift
//  Weather information
//
//  Created by Irina Moiseeva on 14.06.2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class NetworkManager {

    static let shared = NetworkManager()
    
    var delegate: WeatherManagerDelegate?
    
    private init() {}
    
    let urlYandex = "https://api.weather.yandex.ru/v2/forecast"
    let keyHeader = "X-Yandex-API-Key"
    let key = "f4d456a6-3997-4ac6-91e6-978ce04191d1"

    func fetchData(latitude: Double, longitude: Double, completionHandler: @escaping (WeatherModel?, Error?) -> Void) {
        guard let urlR = URL(string: urlYandex) else { return }
               let url = URL(string: "?lat=" + String(latitude) + "&lon="  + String(longitude), relativeTo: urlR)!
               var request = URLRequest(url: url)
               request.addValue(key, forHTTPHeaderField: keyHeader)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let response = response {
                print(response)
            }
            if let saveData = data {
                if let weather = self.parseJSON(saveData){
                    
                    print(weather)
                }
            }
        }
        .resume()
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.info.tzinfo.name
            let conditional = decodedData.fact.condition
            let factTemp = decodedData.fact.temp
            let tempNight = decodedData.forecasts.parts.evening.tempMax
            
            let weather = WeatherModel(cityName: name, temperature: factTemp, temperatureNight: tempNight, condition: conditional)

            return weather

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getCityWeather(cities:[String], completion: @escaping (Int, WeatherModel) -> Void) {
        
        for (index, city) in cities.enumerated() {
            getCoordinate(city: city) { (coordinate, error) in
                
                guard let coordinate = coordinate, error == nil else {return}
                
                self.fetchData(latitude: coordinate.latitude, longitude: coordinate.longitude) { result, error in
                    
                    if let error = error {
                        self.delegate?.didFailWithError(error: error)
                        return
                    }
                    
                    if let weather = result {
                        return completion(index, weather)
                    }
                }
            }
        }
    }
    
    func getWeatherForSeachedCity(city: String, completion: @escaping (WeatherModel) -> Void) {
        getCoordinate(city: city) { (coordinate, error) in
            
            guard let coordinate = coordinate, error == nil else {return}
            
            self.fetchData(latitude: coordinate.latitude, longitude: coordinate.longitude) { result,error in
                
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let weather = result {
                    return completion(weather)
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
