//
//  ForecastDetailsViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit

class ForecastDetailsViewController: UIViewController {
    
    var weather: WeatherModel?
    
    private lazy var cityTextLable: UILabel = {
        let textLable = UILabel()
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var temperatureLable: UILabel = {
        let textLable = UILabel()
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var additionalLable: UILabel = {
        let textLable = UILabel()
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupSubvies()
        setConstraints()
        updateUI()
    }
    
    private func setupSubvies() {
        view.addSubview(cityTextLable)
        view.addSubview(temperatureLable)
        view.addSubview(additionalLable)
        view.addSubview(weatherIcon)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            cityTextLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            cityTextLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cityTextLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            temperatureLable.topAnchor.constraint(equalTo: cityTextLable.bottomAnchor, constant: 20),
            temperatureLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            temperatureLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            temperatureLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            additionalLable.topAnchor.constraint(equalTo: cityTextLable.bottomAnchor, constant: 50),
            additionalLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: temperatureLable.topAnchor, constant: 150),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 120),
            weatherIcon.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func updateUI() {
        
        guard let weath = weather else {return}
        
        DispatchQueue.main.async {
            self.cityTextLable.text = weath.cityName
            self.temperatureLable.text = "Temperature  \(String(weath.temperature))℃"
            self.additionalLable.text = "Temperature at night  \(String(weath.temperatureNight))℃"
            self.weatherIcon.image = UIImage(systemName: "\(weath.conditionName)")
        }
    }
}


