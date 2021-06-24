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
       // textLable.text = "Moscow"
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var temperatureLable: UILabel = {
        let textLable = UILabel()
      //  textLable.text = "Temperature \(temperature)"
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var additionalLable: UILabel = {
        let textLable = UILabel()
       // textLable.text = "Temperature at night \(condition)"
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private var weatherIcon: UIImageView = {
        let view = UIImageView()
     //   view.image = UIImage(systemName: "")
       // view.frame.size.height = 20
       // view.frame.size.width = 20
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        NetworkManager.shared.getCityWeather(cities: Cities().citiesArray) { [weak self] (index, weather) in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.cityTextLable.text = weather.cityName
            self.temperatureLable.text = "Temperature  \(String(weather.temperature))℃"
                self.additionalLable.text = "Temperature at night  \(String(weather.temperatureNight))℃"
                self.weatherIcon.image = UIImage(systemName: "\(weather.conditionName)")
            
            }

        }
        
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
            
//            weatherIcon.topAnchor.constraint(equalTo: additionalLable.bottomAnchor, constant: 10),
//            weatherIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 40),
//            weatherIcon.heightAnchor.constraint(equalToConstant: 40)
            
            
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
            
            if weath.temperature > 0 {
                self.temperatureLable.text = "+ \(weath.temperature) ℃"
            } else {
                self.temperatureLable.text = "\(weath.temperature) ℃"
            }
            self.additionalLable.text = "Temperature at night: \(weath.temperatureNight) м/с"
        }
    }
}


