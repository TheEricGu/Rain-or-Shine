//
//  WeatherCollectionViewCell.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    var weatherImageView: UIImageView!
    var timeLabel: UILabel!
    var degreeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        weatherImageView = UIImageView()
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.contentMode = .scaleAspectFill
        weatherImageView.layer.masksToBounds = true
        contentView.addSubview(weatherImageView)
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(timeLabel)
        
        degreeLabel = UILabel()
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.font = .systemFont(ofSize: 15)
        contentView.addSubview(degreeLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // time label constraints
        NSLayoutConstraint.activate([timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor), timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        // image view constraints
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        // degree label constraints
        NSLayoutConstraint.activate([degreeLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            degreeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), degreeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            degreeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    func configure(weather: Weather) {
        weatherImageView.image = UIImage(named: weather.imageName)
        timeLabel.text = weather.time
        degreeLabel.text = weather.degrees
    }
    
    func filterBy(tag: String) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
