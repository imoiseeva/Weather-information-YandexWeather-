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
    
    func fetchData() {
        guard let urlR = URL(string: urlYandex) else { return }
               let url = URL(string: "?lat=" + String(55.75396) + "&lon="  + String(37.620393), relativeTo: urlR)!
               var request = URLRequest(url: url)
               request.addValue(key, forHTTPHeaderField: keyHeader)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
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
            print(error)
            return nil
        }
    }
    

    
}

  

