////
////  ServiceManager.swift
////  Weather information
////
////  Created by Irina Moiseeva on 22.06.2021.
////
//
//import Foundation
//
//protocol CitiesListViewModelProtocol {
//    
//    var weatherData: WeatherModel? {get}
//    var numberOfRows: Int {get}
//    var reloadData: ()->Void {get}
//    
//    func addCity(city: String, isItCorrectCityName: @escaping(Bool) -> Void)
//    func deleteCity(at indexPath: IndexPath)
//    func fetchWeatherData(clousure: @escaping ()->Void)
//    func showCityWeather(for city: String?, weatherData:@escaping(WeatherModel?)->())
//    func cellViewModel(at indexPath: IndexPath) -> Cell?
//}
//
//class CitiesListViewModel: CitiesListViewModelProtocol {
//    
//    
//    var weatherData: WeatherModel?
//    var cities = Cities()
//    var reloadData: () -> Void
//    var numberOfRows: Int { cities.citiesArray.count }
//    
//    init(reloadData: @escaping () -> Void) {
//        self.reloadData = reloadData
//    }
//    
//    func fetchWeatherData(clousure: @escaping () -> Void) {
//        NetworkManager.shared.fetchData() { data in
//            data = data
//        }
//        }
//    }
//    
//    func cellViewModel(at indexPath: IndexPath) -> WeatherListCellViewModelProtocol? {
//        WeatherListCellViewModel(weatherInfo: self.weatherData?[indexPath.row])
//    }
//    
//    func addCity(city: String, isItCorrectCityName: @escaping(Bool) -> Void) {
//        
//        let locationManager = LocationManager()
//        
//        locationManager.getCoordinate(forCity: city) { (coordinates) in
//            if let _ = coordinates {
//                
//                NetworkManager.shared.fetchWeatherForCities(for: [city]) { (data) in
//                    
//                    if let name = data.first?.geoObject.locality.name, DataManager.shared.isNewCity(city: name) {
//                        DataManager.shared.addCity(city: name)
//                        self.weatherData!.append(data.first)
//                        self.weatherData?.sort{$0!.geoObject.locality.name<$1!.geoObject.locality.name}
//                        self.reloadData()
//                        isItCorrectCityName(true)
//                    }
//                }
//            } else {
//                isItCorrectCityName(false)
//            }
//        }
//    }
//    
//    
//    func showCityWeather(for city: String?, weatherData:@escaping(YandexWeatherData?)->()) {
//        
//        if let city = city, city.count >= 2 {
//            
//            let locationManager = LocationManager()
//            locationManager.getCoordinate(forCity: city) { (coordinates) in
//                if let _ = coordinates {
//                    
//                    NetworkManager.shared.fetchWeatherForCities(for: [city]) { (data) in
//                        if data.isEmpty {
//                            weatherData(nil)
//                        } else {
//                            weatherData(data.first)
//                        }
//                    }
//                } else {
//                    weatherData(nil)
//                }
//            }
//        }
//    }
//    
//    func deleteCity(at indexPath: IndexPath) {
//        
//        DataManager.shared.deleteCity(at: indexPath)
//        self.weatherData?.remove(at: indexPath.row)
//    }
//}
