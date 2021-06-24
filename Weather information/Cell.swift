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
    var weatherData: WeatherData?
    
    var city: String? {
        didSet {
            guard let city = city else { return }
            setupViews(for: cityTextLable.text ?? "")
            setConstraints()
        }
    }
    
    var weather: WeatherModel? {
        didSet {
            guard let city = city else { return }
            setupViews(for: city)
        }
    }
    
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
    
    func setupViews(for city: String) {
        cityTextLable.text = city
        
        guard let weather = weather else { return }
        let temp = weather.temperature
        if temp > 0 {
            temperatureLabel.text = "+ \(weather.temperature) ℃"
        } else {
            temperatureLabel.text = " \(weather.temperature) ℃"
        }
    }
    
    func setupSubvies() {
        [cityTextLable, temperatureLabel, weatherIcon].forEach {
            contentView.addSubview($0)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            cityTextLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            cityTextLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherIcon.leadingAnchor, constant: -offset),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            weatherIcon.heightAnchor.constraint(equalTo: weatherIcon.widthAnchor),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
    
    func configureData(weather: WeatherModel) {
        
        self.cityTextLable.text = weather.cityName
        self.weatherIcon.image = UIImage(systemName: weather.conditionName)
        if weather.temperature > 0 {
            self.temperatureLabel.text = "+ \(weather.temperature) ℃"
        } else {
            self.temperatureLabel.text = " \(weather.temperature) ℃"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let view = weatherIcon.subviews.first {
            view.removeFromSuperview()
        }
    }
}
