//
//  WeatherViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate {
    
    private let headerView = UIView()
    var weatherCollectionView: UICollectionView!
    var outfitsCollectionView: UICollectionView!
    
    let weatherCellReuseIdentifier = "weatherCellReuseIdentifier"
    let outfitsCellReuseIdentifier = "outfitsCellReuseIdentifier"
    
    let padding: CGFloat = 2
    let headerHeight: CGFloat = 50
    
    let headerID = "Header" // section header for outfits
    
    // set up weather
    var hourly: [RealHourly] = []
    var current: [Current] = []
    var iconName: String = "01d"
    var iconDescriptionText: String = "foo"
    var currentTemp: String = "foo temp"
    var feelsLike: String = "Feels like "
    var rainChance: String = "Rain "
    var windSpeed: String = "Wind "
    var data: [WeatherData] = []
    
    // set up outfits
    var outfits: [Outfit] = []
    var realOutfits: [RealOutfit] = []
    
    func getHourly() {
        OpenWeatherManager.getHourly { hourlyData in
            let sliced = hourlyData[0...12]
            let data = Array(sliced)
            self.hourly = data
            self.rainChance = "Rain " + String(format:"%.1f", hourlyData[0].pop * 100) + "%"
            self.windSpeed = "Wind " + String(format:"%.1f", hourlyData[0].wind_speed) + " mph"
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
                let rainLabelLayer = CATextLayer()
                let rainLabelAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10.5, weight: .semibold),
                    .foregroundColor: UIColor.white,
                ]
                rainLabelLayer.string = NSAttributedString(string: (self.rainChance + " | " + self.windSpeed), attributes: rainLabelAttributes)
                rainLabelLayer.alignmentMode = .center
                rainLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
                rainLabelLayer.frame = CGRect(x: 69, y: 69, width: 350, height: 50)
                rainLabelLayer.position = CGPoint(x: self.headerView.frame.maxX / 3, y: self.headerView.frame.maxY / 4 + 71)
                self.headerView.layer.addSublayer(rainLabelLayer)
            }
        }
    }
    func getOutfits(weather: String, temperatureWord: String) {
        self.outfits = []
        print(UserDefaults.standard.string(forKey: "Gender")!)
        let gender_lowercase = UserDefaults.standard.string(forKey: "Gender")!.lowercased()
        OutfitsManager.getWeatherOutfits(gender: gender_lowercase, season: "winter", weather: weather, temperatureWord: temperatureWord) { weatherOutfitData in
            for realOutfit in weatherOutfitData {
                print(realOutfit.url)
                let newOutfit : Outfit = Outfit(imageName: realOutfit.url, weatherTags: [realOutfit.gender, realOutfit.season, realOutfit.weather, realOutfit.temp], didLike: false, userPosted: false)
                self.outfits.append(newOutfit)
                DispatchQueue.main.async {
                    self.outfitsCollectionView.reloadData()
            }
        }
    }
    }
    
    func getCurrent() {
        OpenWeatherManager.getCurrent { currentData in
            self.current = [currentData]
            self.iconName = currentData.weather[0].icon
            self.iconDescriptionText = currentData.weather[0].description
            self.currentTemp = String(format:"%.0f", currentData.temp)
            self.feelsLike = "Feels like "
            self.feelsLike = self.feelsLike + String(format:"%.0f", currentData.feels_like)
            var temperatureWord = ""
            if (Int(self.currentTemp)! < 21) {
                temperatureWord = "freezing"
            }
            else if (Int(self.currentTemp)! < 40) {
                temperatureWord = "cold"
            }
            else if (Int(self.currentTemp)! < 60) {
                temperatureWord = "chilly"
            }
            else if (Int(self.currentTemp)! < 80) {
                temperatureWord = "moderate"
            }
            else if (Int(self.currentTemp)! < 90) {
                temperatureWord = "warm"
            }
            else {
                temperatureWord = "hot"
            }
            var weatherWord = ""
            if currentData.weather[0].main.lowercased() == "thunderstorm" {
                weatherWord = "thunder"
            }
            else if currentData.weather[0].main.lowercased() == "drizzle" {
                weatherWord = "drizzle"
            }
            else if currentData.weather[0].main.lowercased() == "rain" {
                weatherWord = "rain"
            }
            else if currentData.weather[0].main.lowercased() == "snow" {
                weatherWord = "snow"
            }
            else if currentData.weather[0].main.lowercased() == "clear" {
                weatherWord = "clear"
            }
            else {
                weatherWord = "cloudy"
            }
            self.getOutfits(weather: weatherWord, temperatureWord: temperatureWord)
            DispatchQueue.main.async {
                self.headerView.backgroundColor = .white
                let backgroundLayer1 = CAShapeLayer()
                backgroundLayer1.path = UIBezierPath(roundedRect: CGRect(x: 12, y: 12, width: self.headerView.frame.maxX - 24, height: self.headerView.frame.maxY/2), cornerRadius: 20).cgPath
                backgroundLayer1.fillColor = UIColor(red: 0.608, green: 0.813, blue: 0.929, alpha: 1).cgColor
                self.headerView.layer.addSublayer(backgroundLayer1)
                
//                let backgroundLayer2 = CAShapeLayer()
//                backgroundLayer2.path = UIBezierPath(roundedRect: CGRect(x: 12, y: 12, width: self.headerView.frame.maxX - 24, height: 125), cornerRadius: 20).cgPath
//                backgroundLayer2.fillColor = UIColor(red: 0.608, green: 0.813, blue: 0.929, alpha: 1).cgColor
//                self.headerView.layer.addSublayer(backgroundLayer2)
                
                let iconLayer = CALayer()
                let iconImage = UIImage(named: (self.iconName + "med"))?.cgImage
                iconLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                iconLayer.contents = iconImage
                iconLayer.position = CGPoint(x: self.headerView.frame.maxX / 3 * 2, y: self.headerView.frame.maxY / 4)
                self.headerView.layer.addSublayer(iconLayer)
                
                let iconLabelLayer = CATextLayer()
                let iconLabelAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 13.0, weight: .semibold),
                    .foregroundColor: UIColor.white,
                ]
                iconLabelLayer.string = NSAttributedString(string: self.iconDescriptionText, attributes: iconLabelAttributes)
                iconLabelLayer.alignmentMode = .center
                iconLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
                iconLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
                iconLabelLayer.position = CGPoint(x: self.headerView.frame.maxX / 3 * 2, y: self.headerView.frame.maxY / 4 + 52)
                self.headerView.layer.addSublayer(iconLabelLayer)
                
                let tempLabelLayer = CATextLayer()
                let tempLabelAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24.0, weight: .semibold),
                    .foregroundColor: UIColor.orange,
                ]
                tempLabelLayer.string = NSAttributedString(string: self.currentTemp + "°", attributes: tempLabelAttributes)
                tempLabelLayer.alignmentMode = .center
                tempLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
                tempLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
                tempLabelLayer.position = CGPoint(x: self.headerView.frame.maxX / 3, y: self.headerView.frame.maxY / 4 + 20)
                self.headerView.layer.addSublayer(tempLabelLayer)
                
                let feelsLabelLayer = CATextLayer()
                let feelsLabelAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.orange,
                ]
                feelsLabelLayer.string = NSAttributedString(string: self.feelsLike + "°", attributes: feelsLabelAttributes)
                feelsLabelLayer.alignmentMode = .center
                feelsLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
                feelsLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
                feelsLabelLayer.position = CGPoint(x: self.headerView.frame.maxX / 3, y: self.headerView.frame.maxY / 4 + 50)
                self.headerView.layer.addSublayer(feelsLabelLayer)
                
                let cityLabelLayer = CATextLayer()
                let cityLabelAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 24.0, weight: .bold),
                    .foregroundColor: UIColor.white,
                ]
                cityLabelLayer.string = NSAttributedString(string: UserDefaults.standard.string(forKey: "Location")!, attributes: cityLabelAttributes)
                cityLabelLayer.alignmentMode = .center
                cityLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
                cityLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
                cityLabelLayer.position = CGPoint(x: self.headerView.frame.maxX / 3, y: self.headerView.frame.maxY / 4 - 7)
                self.headerView.layer.addSublayer(cityLabelLayer)
                self.weatherCollectionView.reloadData()
                
                
            }
        }
    }
    
    func getData() {
        OpenWeatherManager.getData { data in
            self.data = [data]
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
//        getData()
//        getCurrent()
//        do {
//            sleep(1)
//        }
//        getHourly()
//        super.viewDidLoad()
        
        // SET USER DEFAULTS FOR WHOLE APP HERE?
        let defaults = UserDefaults.standard
        defaults.set("Mathew Scullin", forKey: "Name")
        defaults.set("Male", forKey: "Gender")
        let likedArray: [Outfit] = []
        defaults.setStructArray(likedArray, forKey: "Liked outfits")
        let postedArray: [Outfit] = []
        defaults.setStructArray(postedArray, forKey: "Posted outfits")
        defaults.set("Ithaca, NY", forKey: "Location")
        // defaults.string(forKey: "Gender") THIS IS HOW YOU ACCESS USER DEFAULTS
        
        self.view.backgroundColor = UIColor.white
        navigationItem.title = "Weather" // TODO: Change to user's location
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        // weather
        let weatherLayout = UICollectionViewFlowLayout()
        weatherLayout.scrollDirection = .horizontal
        weatherLayout.minimumInteritemSpacing = padding
        weatherLayout.minimumLineSpacing = padding
        
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: weatherLayout)
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: weatherCellReuseIdentifier)
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.backgroundColor = .white
        weatherCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(weatherCollectionView)
        
        // outfits
//        outfits = [outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1]
        let outfitsLayout = UICollectionViewFlowLayout()
        outfitsLayout.scrollDirection = .vertical
        outfitsLayout.minimumInteritemSpacing = padding
        outfitsLayout.minimumLineSpacing = padding
        
        outfitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: outfitsLayout)
        outfitsCollectionView.register(OutfitsCollectionViewCell.self, forCellWithReuseIdentifier: outfitsCellReuseIdentifier)
        outfitsCollectionView.dataSource = self
        outfitsCollectionView.delegate = self
        outfitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        outfitsCollectionView.backgroundColor = .white
        outfitsCollectionView.showsHorizontalScrollIndicator = false
        outfitsCollectionView.showsVerticalScrollIndicator = false

        view.addSubview(outfitsCollectionView)
        
        // for section header
        outfitsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        let flow = outfitsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSize(width: 30,height: 30)
        
        setupConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        getCurrent()
        do {
            sleep(1)
        }
        getHourly()
        
        let outfitsLayout = UICollectionViewFlowLayout()
        outfitsLayout.scrollDirection = .vertical
        outfitsLayout.minimumInteritemSpacing = padding
        outfitsLayout.minimumLineSpacing = padding
        
        outfitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: outfitsLayout)
        outfitsCollectionView.register(OutfitsCollectionViewCell.self, forCellWithReuseIdentifier: outfitsCellReuseIdentifier)
        outfitsCollectionView.dataSource = self
        outfitsCollectionView.delegate = self
        outfitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        outfitsCollectionView.backgroundColor = .white
        outfitsCollectionView.showsHorizontalScrollIndicator = false
        outfitsCollectionView.showsVerticalScrollIndicator = false

        view.addSubview(outfitsCollectionView)
        
        // for section header
        outfitsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        let flow = outfitsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSize(width: 30,height: 30)
        
        setupConstraints()
    }

    
    private func setupConstraints() {
        // header
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: view.frame.height/4)
        ])
        
        // weather collection view
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 95),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            weatherCollectionView.bottomAnchor.constraint(equalTo: outfitsCollectionView.topAnchor)
        ])
        
        // outfits collection view
        NSLayoutConstraint.activate([
            outfitsCollectionView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor),
            outfitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitsCollectionView.heightAnchor.constraint(equalToConstant: 500),
            outfitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outfitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    // for section header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            var v : UICollectionReusableView! = nil
            if kind == UICollectionView.elementKindSectionHeader {
                v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
                if v.subviews.count == 0 {
                    v.addSubview(UILabel(frame:CGRect(x: 0,y: 0,width: 150,height: 30)))
                }
                let lab = v.subviews[0] as! UILabel
                lab.text = "Explore outfits"
                lab.textAlignment = .center
            }
            return v
}
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.weatherCollectionView {
            return hourly.count
        }
        else {
            return outfits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.weatherCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherCellReuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
            cell.configure(hourly: hourly[indexPath.item], data: data[0], index: indexPath.row)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: outfitsCellReuseIdentifier, for: indexPath) as! OutfitsCollectionViewCell
            cell.configure(outfit: outfits[indexPath.item])
            return cell
       }
}
}

    
extension WeatherViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.weatherCollectionView {
            let size = (collectionView.frame.width - 2 * padding) / 5.0
            return CGSize(width: size, height: 100)
        }
        else {
            let size = (collectionView.frame.width - 2 * padding) / 3.0
            return CGSize(width: size, height: 200)
        }
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.outfitsCollectionView{
            let outfit = outfits[indexPath.row]
            let outfitViewController = OutfitViewController(outfit: outfit)
            navigationController?.pushViewController(outfitViewController, animated: true)
        }
    }
}
