//
//  ViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit
import CoreLocation

class CitiesListViewController: UITableViewController {
    
    var city = Cities().citiesArray
    var networkManager = NetworkManager.shared
    var citiesListWeather: [WeatherModel] = []
    var weatherModel = WeatherModel()

   // var weatherData = WeatherData()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
 
        setupNavigationBar()
        searchBar()
        getCitiesWeather()
        tableView.reloadData()
        
        if citiesListWeather.isEmpty {
            citiesListWeather = Array(repeating: weatherModel, count: city.count)
        }
    }
    private func setupNavigationBar() {
        title = "Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Navigation Bar Apearence
        let navBarApearence = UINavigationBarAppearance()
        navBarApearence.configureWithOpaqueBackground()
        navBarApearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApearence.backgroundColor = UIColor(
            red: 130/255,
            green: 0/255,
            blue: 252/255,
            alpha: 194/255
        )
        navigationController?.navigationBar.standardAppearance = navBarApearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApearence
        
        //Add button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newCityAlert)
        )
        navigationController?.navigationBar.tintColor = .white
        tableView.register(Cell.self, forCellReuseIdentifier: "MyCell")
    }
    
    func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "search"
        navigationItem.searchController?.searchBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func newCityAlert() {
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.city.append(task)
           // self.getCitiesWeather()
            self.tableView.reloadData()

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
       
    }
    
    @objc private func addNewCity() {

//        let cityDetails = ForecastDetailsViewController()
//        present(cityDetails, animated: true)
    }
    
//    private func fetchData(from url: String?) {
//        NetworkManager.shared.fetchData(from: url) {  weatherData in
//            self.weatherData = weatherData
//            self.tableView.reloadData()
//        }
//    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        citiesListWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(Cell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Cell
       
        var weather = WeatherModel()
        weather = citiesListWeather[indexPath.row]
       
        cell.setupSubvies()
        cell.configureData(weather: weather)
        
//        var content = cell.defaultContentConfiguration()
//        let city = citiesListWeather[indexPath.row]
//        content.text = city.cityName
//        cell.configureData(weather: weatherModel)
//
//        cell.contentConfiguration = content
        
        
//        var weather = WeatherModel()
//     //   weather = citiesListWeather[indexPath.row]
//
//        cell.configureData(weather: weather)
//
//
//        weather.cityName = city[indexPath.row]
//
//
//        let city = citiesListWeather[indexPath.row]
//        cell.city = weatherModel.cityName
//        if let weather = WeatherData(from: city as! Decoder) {
//            cell.weather = weather
//        }
        
//        cell.setupSubvies()
//        cell.configureData(weather: weather)

      
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetails = ForecastDetailsViewController()
       cityDetails.cityTextLable.text = city[indexPath.row]
        present(cityDetails, animated: true)
    }


//MARK: - Get data from NatworkManager
//extension CitiesListViewController {
//
//    func showCityWeather(for city: String?, weatherData:@escaping(WeatherModel?)->()) {
//
//        if let city = city, city.count >= 2 {
//
//            //let locationManager = networkManager
//            networkManager.getCoordinate(city: city, completion: { coordinates, error in
//
//                if let _ = coordinates {
//
//                    networkManager.fetchWeatherForCities(for: [city]) { (data) in
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
    
    
    func getCitiesWeather() {
        NetworkManager.shared.getCityWeather(cities: city) { [weak self] (index, weather) in
            guard let self = self else { return }
            self.citiesListWeather[index] = weather
            self.citiesListWeather[index].cityName = self.city[index]

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
