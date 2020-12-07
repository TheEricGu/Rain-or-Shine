//
//  WeatherViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

//protocol outfitDelegate: class {
////    func saveNewNameModal(newName: String?)
////    func saveNewNameNav(newName: String?)
//}


class WeatherViewController: UIViewController, UICollectionViewDelegate {
    
    private let headerView = UIView()
    var weatherCollectionView: UICollectionView!
    var outfitsCollectionView: UICollectionView!
    
    let weatherCellReuseIdentifier = "weatherCellReuseIdentifier"
    let outfitsCellReuseIdentifier = "outfitsCellReuseIdentifier"
    
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
    
    // set up weather
    var hourly: [RealHourly] = []
    var current: [Current] = []
    var data: [Data] = []
    
    // set up outfits
    let outfit1 = Outfit(imageName: "clothes1.jpeg", weatherTags: ["winter", "cloudy"], didLike: false)
    var outfits: [Outfit] = []
    
    func getHourly() {
        OpenWeatherManager.getHourly { hourlyData in
            let sliced = hourlyData[0...12]
            let data = Array(sliced)
            self.hourly = data
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    func getCurrent() {
        OpenWeatherManager.getCurrent { currentData in
            self.current = [currentData]
            DispatchQueue.main.async {
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
        super.viewDidLoad()
        getHourly()
        getCurrent()
        getData()
        self.view.backgroundColor = UIColor.white
        navigationItem.title = "weather"
        headerView.backgroundColor = .gray
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
        view.addSubview(weatherCollectionView)
        
        // outfits
        outfits = [outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1,outfit1]
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
        view.addSubview(outfitsCollectionView)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        // header
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // weather collection view
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 100),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        
        // outfits collection view
        NSLayoutConstraint.activate([
            outfitsCollectionView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: padding),
            outfitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitsCollectionView.heightAnchor.constraint(equalToConstant: 500),
            outfitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
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
            cell.configure(hourly: hourly[indexPath.item], data: data[0])
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
