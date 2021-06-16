//
//  ForecastDetailsViewController.swift
//  Weather information
//
//  Created by Irina Moiseeva on 11.06.2021.
//

import UIKit

class ForecastDetailsViewController: UIViewController {
    
    //private lazy
    var cityTextLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Moscow"
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        return textLable
    }()
    
    private lazy var temperatureLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Moscow"
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        return textLable
    }()
    
    private lazy var additionalLable: UILabel = {
        let textLable = UILabel()
        textLable.text = "Moscow"
        textLable.font = UIFont.boldSystemFont(ofSize: 35.0)
        textLable.textAlignment = .center
        return textLable
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupSubvies()
        setConstraints()
    }
    
    private func setupSubvies() {
        view.addSubview(cityTextLable)
        
    }
    
    private func setConstraints() {
        cityTextLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityTextLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            cityTextLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cityTextLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


