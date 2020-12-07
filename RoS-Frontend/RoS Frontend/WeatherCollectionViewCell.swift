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
 
//    func scaleUIImageToSize(image: UIImage, size: CGSize) -> UIImage! {
//        let hasAlpha = false
//        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
//
//        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
//        image.draw(in: (CG(origin: CGPoint.zero, size: size)))
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return scaledImage!
//    }
    
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
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor)])
        
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
    
    func configure(hourly: RealHourly, data: Data) {
        let image = UIImage(named: hourly.weather[0].icon)!
        weatherImageView.image = image
        
        let date = unixToDate(unix: Double(hourly.dt + data.timezone_offset))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "H"
        let intTime : Int! = Int(formatter.string(from: date))
        var finalTime = "you messed up"
        if intTime > 12 {
            finalTime = String(intTime - 12) + " PM"
        }
        else if intTime == 0 {
            finalTime = "12 AM"
        }
        else {
            finalTime = String(intTime) + " AM"
        }
        timeLabel.text = String(finalTime)
        // rounds float to nearest int and makes into string
        
        degreeLabel.text = String(format:"%.0f", hourly.temp) + "°"
    }
    
    func filterBy(tag: String) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
