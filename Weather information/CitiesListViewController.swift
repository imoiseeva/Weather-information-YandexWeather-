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
            action: #selector(addNewCity)
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
    
    @objc private func addNewCity() {
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.citiesListWeather.append(self.weatherModel)
            self.city.append(task)
            self.getCitiesWeather()
            self.tableView.reloadData()

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
       
    }
    
//    @objc private func addNewCity() {
//
//        let cityDetails = ForecastDetailsViewController()
//       present(cityDetails, animated: true)
//    }
    
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
       
        weatherModel = citiesListWeather[indexPath.row]
        cell.setupSubvies()
        cell.configureData(weather: weatherModel)
      
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetails = ForecastDetailsViewController()
        
      // cityDetails.name = city[indexPath.row]
//        cityDetails.temperature = weatherModel.temperature
//        cityDetails.condition = weatherModel.condition
        present(cityDetails, animated: true)
    }
 
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

// MARK: - Search Bar protocols

extension CitiesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let cityName = searchBar.text?.capitalized, !cityName.isEmpty{
                   let cityDetails = ForecastDetailsViewController()
                  present(cityDetails, animated: true)
            
//            NetworkManager.shared.locationError = { [weak self] locationError in
//                guard let self = self else { return }
//                self.alertIfLocationNotFound()
//            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}
