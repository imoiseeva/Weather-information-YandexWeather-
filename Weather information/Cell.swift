//
//  Cell.swift
//  Weather information
//
//  Created by Irina Moiseeva on 17.06.2021.
//

import UIKit

class Cell: UITableViewCell {
    
    private let offset: CGFloat = 16
    private let width: CGFloat = 50
    
    private var cityTextLable: UILabel = {
        let label = UILabel()
        label.text = "Город"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupSubvies() {
        [cityTextLable, temperatureLabel, weatherIcon].forEach {
            contentView.addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        cityTextLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cityTextLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            cityTextLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -offset),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            weatherIcon.widthAnchor.constraint(equalToConstant: width),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        if let view = weatherIcon.subviews.first {
//            view.removeFromSuperview()
//        }
//    }
    
}
//MARK: - WeatherManagerDelegate

extension Cell {
    
    func updateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityTextLable.text = String(weather.cityName)
            self.temperatureLabel.text = String(weather.temperature)
            self.weatherIcon.image = UIImage(named: weather.conditionName)
        }
    }
}
