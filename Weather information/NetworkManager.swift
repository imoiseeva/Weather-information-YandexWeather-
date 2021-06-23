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

    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
               guard let urlR = URL(string: urlYandex) else { return }
                       let url = URL(string: "?lat=" + String(latitude) + "&lon="  + String(longitude), relativeTo: urlR)!
                       var request = URLRequest(url: url)
                      request.addValue(key, forHTTPHeaderField: keyHeader)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print(error)
                return
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


    
//    private func parseJSON(withData data: Data) -> WeatherModel? {
//
//        let decoder = JSONDecoder()
//        do {
//            let currentWeatherData = try decoder.decode(WeatherModel.self, from: data)
//            return currentWeatherData
//
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        return nil
//    }

    
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


//    func fetchData(from url: String?, with complition: @escaping (WeatherData) -> Void) {
//        guard let stringURL = url else { return }
//        guard let url = URL(string: stringURL) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                guard let weather = WeatherModel(weatherData: weatherData) else {return}
//                completion(.success(weather))
//                DispatchQueue.main.async {
//                    complition(weatherData)
//                }
//            } catch let error {
//                print(error)
//            }
//
//        }.resume()
//    }


//    func fetchData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
//
//        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru_RU"
//
//        guard let url = URL(string: urlString) else {
//
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue(key, forHTTPHeaderField: keyHeader)
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print(error)
//                return
//            }
//
//            if 200...299 ~= response.statusCode {
//                if let data = data {
//                    do {
//                        let json = try JSONDecoder().decode(WeatherData.self, from: data)
//
//                        guard let weather = WeatherModel(weatherData: json) else {return}
//                        completion(.success(weather))
//                    } catch {
//                        return
//                    }
//                }
//
//            } else {
//               return
//            }
//        }
//        .resume()
//    }

//    func  fetchData(complitionHandeler: @escaping(WeatherModel)->Void)  {
//
//        let url = URL(string: urlYandex)
//        if let unwrappedURL = url {
//            var request = URLRequest(url: unwrappedURL)
//            request.addValue(key, forHTTPHeaderField: keyHeader)
//            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//                guard let data = data else { return }
//
//                do {
//                    let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
//                    DispatchQueue.main.async {
//                        complition(weatherData)
//                    }
//                } catch let error {
//                    print(error)
//                }
//
//            }.resume()
////                if let data = data {
////                    if let weatherData = self.parseJSON(withData: data) {
////                    complitionHandeler(weatherData)
////                    }
////                }
////            }
////            dataTask.resume()
//        }
//    }

//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//           let weather = WeatherModel(weatherData: decodedData)
//            DispatchQueue.main.async {
//
//            }
//        } catch let error {
//            print(error)
//        }
////        do {
////            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
////            guard let weather = WeatherModel(weatherData: decodedData) else {return}
////
////        } catch {
////
////        }
////            let name = decodedData.info.tzinfo.name
////            let conditional = decodedData.fact.condition
////            let factTemp = decodedData.fact.temp
////            let tempNight = decodedData.forecasts.parts.evening.tempMax
////
////            let weather = WeatherModel(cityName: name, temperature: factTemp, temperatureNight: tempNight, condition: conditional)
//
//            return
//
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }

//
//    private func getWeatherRequest(for city: String) -> Result<URLRequest, CLError>? {
//        var locationCoordinate: Result<CLLocationCoordinate2D, CLError>?
//        let group = DispatchGroup()
//        group.enter()
//        getCoordinate(city: city) { result,<#arg#>  in
//            switch result {
//            case .success(let coordinate):
//                locationCoordinate = .success(coordinate)
//            case .failure(let error):
//                print(type(of: self), #function, "\(error.localizedDescription)")
//                locationCoordinate = .failure(error)
//            }
//            group.leave()
//        }
//
//    func getWeatherForSeachedCity(city: String, completion: @escaping (WeatherModel) -> Void) {
//        getCoordinate(city: city) { (coordinate, error) in
//
//            guard let coordinate = coordinate, error == nil else {return}
//
//            self.fetchData(complitionHandeler: WeatherData) { result in
//
//                if let error = error {
//                    self.delegate?.didFailWithError(error: error)
//                    return
//                }
//                switch result {
//                case .success(let weather):
//                    completion( weather)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }


//    func fetchData(latitude: Double, longitude: Double, completionHandler: @escaping (WeatherModel?, Error?) -> Void) {
//        guard let urlR = URL(string: urlYandex) else { return }
//               let url = URL(string: "?lat=" + String(latitude) + "&lon="  + String(longitude), relativeTo: urlR)!
//               var request = URLRequest(url: url)
//               request.addValue(key, forHTTPHeaderField: keyHeader)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                self.delegate?.didFailWithError(error: error)
//                return
//            }
//            if let response = response {
//                print(response)
//            }
//            if let saveData = data {
//                if let weather = self.parseJSON(saveData){
//
//                    print(weather)
//                }
//            }
//        }
//        .resume()
//    }
