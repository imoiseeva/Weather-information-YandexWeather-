//
//  ViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit
import CoreLocation

class CitiesListViewController: UITableViewController {
    
    var city = WeatherModel()
    var networkManager = NetworkManager.shared
    var citiesListWeather: [WeatherModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
 
        setupNavigationBar()
        searchBar()
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
    }
    
    func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func newCityAlert() {
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.city.citiesArray.append(task)
            self.tableView.reloadData()
            self.getCitiesWeather()
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
}

// MARK: - TAble View Data Source
extension CitiesListViewController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        city.citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(Cell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Cell
        var content = cell.defaultContentConfiguration()
        let task = citiesListWeather[indexPath.row]
        cell.setupSubvies()
        cell.updateWeather(weather: task)

        cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetails = ForecastDetailsViewController()
        cityDetails.cityTextLable.text = city.citiesArray[indexPath.row]
        present(cityDetails, animated: true)
    }}


//MARK: - Get data from NatworkManager
extension CitiesListViewController {
    func getCitiesWeather() {
        NetworkManager.shared.getCityWeather(cities: city.citiesArray) { [weak self] (index, weather) in
            guard let self = self else { return }
            self.citiesListWeather[index] = weather
            self.citiesListWeather[index].cityName = self.city.citiesArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
