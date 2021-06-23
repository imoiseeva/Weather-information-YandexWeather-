//
//  ForecastDetailsViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit

class ForecastDetailsViewController: UIViewController {
    
    private(set) lazy var cityTextLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Moscow"
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var temperatureLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Temperature"
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    private lazy var additionalLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Temperature at night"
        textLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLable.textAlignment = .center
        textLable.translatesAutoresizingMaskIntoConstraints = false
        return textLable
    }()
    
    var weather: WeatherModel?
    
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
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            cityTextLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            cityTextLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cityTextLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            temperatureLable.topAnchor.constraint(equalTo: cityTextLable.bottomAnchor, constant: 7),
            temperatureLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            temperatureLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            temperatureLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            additionalLable.topAnchor.constraint(equalTo: cityTextLable.bottomAnchor, constant: 50),
            additionalLable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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


