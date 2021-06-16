//
//  ViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit

class CitiesListViewController: UITableViewController {
    
    let city = Cities().citiesArray
    
//    private lazy var searchBar: UISearchBar = {
//        let bar = UISearchBar()
//       // bar.delegate = self
//        bar.placeholder = "Search..."
//        return bar
//    }()
    
//    let searchBar: UISearchController = {
//        let bar = UISearchController()
//       // bar.delegate = self
//        bar.title = "Search..."
//        return bar
//    }()


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
            action: #selector(addNewCity)
        )
        navigationController?.navigationBar.tintColor = .white
    }
    
    func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
//
//    private func addDoneButton() {
//
//
//            let keyboardToolbar = UIToolbar()
//            keyboardToolbar.sizeToFit()
//
//            let doneButton = UIBarButtonItem(
//                title:"Done",
//                style: .done,
//                target: self,
//                action: #selector(didTapDone)
//            )
//
//            let flexBarButton = UIBarButtonItem(
//                barButtonSystemItem: .flexibleSpace,
//                target: nil,
//                action: nil
//            )
//
//            keyboardToolbar.items = [flexBarButton, doneButton]
//
//
//    }
//
//    @objc private func didTapDone() {
//
//       present(ForecastDetailsViewController(), animated: true)
//
//      //  view.endEditing(true)
//    }

    
    @objc private func addNewCity() {
        let cityDetails = ForecastDetailsViewController()
        present(cityDetails, animated: true)
    }

}

// MARK: - TAble View Data Source
extension CitiesListViewController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let task = city[indexPath.row]
        content.text = task
        content.secondaryText = city[indexPath.row]
       
        
        cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = NetworkManager.shared.fetchData()
//        print(data)
        let cityDetails = ForecastDetailsViewController()
        cityDetails.cityTextLable.text = city[indexPath.row]
        present(cityDetails, animated: true)
    }
}

// MARK: - Work with keyboard
extension CitiesListViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField{
//
//        } else {
//            logInPressed()
//        }
//        return true
//    }
}
