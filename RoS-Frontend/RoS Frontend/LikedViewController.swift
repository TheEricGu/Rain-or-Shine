//
//  LikedViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

// TODO: CHANGE USER DEFAULTS: LIKED OUTFITS ARRAY ON FILTER TOGGLING

class LikedViewController: UIViewController, UICollectionViewDelegate {
 //   private let searchBar = UISearchBar()
    var seasonsCollectionView: UICollectionView!
    var tempsCollectionView: UICollectionView!
    var weatherCollectionView: UICollectionView!
    var outfitsCollectionView: UICollectionView!
    var instructionsLabel: UILabel!
   
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let outfitsCellReuseIdentifier = "outfitsCellReuseIdentifier"
   
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
   
    // set up filter
    let autumn = Filter(filterName: "Autumn", didSelect: false)
    let spring = Filter(filterName: "Spring", didSelect: false)
    let summer = Filter(filterName: "Summer", didSelect: false)
    let winter = Filter(filterName: "Winter", didSelect: false)
    var seasonFilters: [Filter] = []
    
    let freezing = Filter(filterName: "Freezing \n(Below 20°)", didSelect: false)
    let cold = Filter(filterName: "Cold \n(21°-40°)", didSelect: false)
    let chilly = Filter(filterName: "Chilly \n(41°-60°)", didSelect: false)
    let moderate = Filter(filterName: "Moderate \n(61°-80°)", didSelect: false)
    let warm  = Filter(filterName: "Warm \n(81°-90°)", didSelect: false)
    let hot = Filter(filterName: "Hot \n(Above 90°)", didSelect: false)
    var tempFilters: [Filter] = []
    
    let thunderstorm = Filter(filterName: "Thunder", didSelect: false)
    let drizzle = Filter(filterName: "Drizzle", didSelect: false)
    let rain = Filter(filterName: "Rain", didSelect: false)
    let snow = Filter(filterName: "Snow", didSelect: false)
    let clear  = Filter(filterName: "Clear", didSelect: false)
    let clouds = Filter(filterName: "Cloudy", didSelect: false)
    var weatherFilters: [Filter] = []
    
    var filtersPressed: [Filter] = []
    var outfits: [Outfit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
   
        navigationItem.title = "Liked Outfits"
        // self.view.backgroundColor = .white
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "clouds.jpg")!)
       
        // search bar
//        searchBar.backgroundColor = .white
//        searchBar.backgroundImage = UIImage()
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.placeholder = "Search liked outfits by tags"
//        searchBar.searchTextField.backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.949, alpha: 1)
//        searchBar.searchTextField.textColor = .black
//        searchBar.searchTextField.font = .systemFont(ofSize: 14)
//        searchBar.searchTextField.clearButtonMode = .never
//        searchBar.layer.cornerRadius = 15
//        searchBar.layer.masksToBounds = true
//        view.addSubview(searchBar)
        
        // instructions label
        instructionsLabel = UILabel()
        instructionsLabel.text = "Tap filters below to find your perfect outfit!"
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.font = .boldSystemFont(ofSize: 20)
        instructionsLabel.textAlignment = .center
        view.addSubview(instructionsLabel)
       
        // filter
        seasonFilters = [autumn, spring, summer, winter]
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = padding
        filterLayout.minimumLineSpacing = padding

        seasonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        seasonsCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        seasonsCollectionView.dataSource = self
        seasonsCollectionView.delegate = self
        seasonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        seasonsCollectionView.backgroundColor = UIColor.clear
        seasonsCollectionView.showsVerticalScrollIndicator = false
        seasonsCollectionView.showsHorizontalScrollIndicator = false
        seasonsCollectionView.allowsMultipleSelection = true
        view.addSubview(seasonsCollectionView)
        
        tempFilters = [freezing, cold, chilly, moderate, warm, hot]
        tempsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        tempsCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        tempsCollectionView.dataSource = self
        tempsCollectionView.delegate = self
        tempsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tempsCollectionView.backgroundColor = UIColor.clear
        tempsCollectionView.showsVerticalScrollIndicator = false
        tempsCollectionView.showsHorizontalScrollIndicator = false
        tempsCollectionView.allowsMultipleSelection = true
        view.addSubview(tempsCollectionView)
        
        weatherFilters = [thunderstorm, drizzle, rain, snow, clear, clouds]
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        weatherCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.backgroundColor = UIColor.clear
        weatherCollectionView.showsVerticalScrollIndicator = false
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.allowsMultipleSelection = true
        view.addSubview(weatherCollectionView)
        
        // outfits
        // set up outfits
        // TODO: GET LIKED OUTFITS ONLY!
        outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
        print(outfits)
        let outfitsLayout = UICollectionViewFlowLayout()
        outfitsLayout.scrollDirection = .vertical
        outfitsLayout.minimumInteritemSpacing = padding
        outfitsLayout.minimumLineSpacing = padding

        outfitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: outfitsLayout)
        outfitsCollectionView.register(OutfitsCollectionViewCell.self, forCellWithReuseIdentifier: outfitsCellReuseIdentifier)
        outfitsCollectionView.dataSource = self
        outfitsCollectionView.delegate = self
        outfitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        outfitsCollectionView.backgroundColor = UIColor.clear
        outfitsCollectionView.showsVerticalScrollIndicator = false
        outfitsCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(outfitsCollectionView)
       
        //setupConstraints()
//        outfitsCollectionView.reloadData()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // filter
        seasonFilters = [autumn, spring, summer, winter]
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = padding
        filterLayout.minimumLineSpacing = padding

        seasonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        seasonsCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        seasonsCollectionView.dataSource = self
        seasonsCollectionView.delegate = self
        seasonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        seasonsCollectionView.backgroundColor = UIColor.clear
        seasonsCollectionView.showsVerticalScrollIndicator = false
        seasonsCollectionView.showsHorizontalScrollIndicator = false
        seasonsCollectionView.allowsMultipleSelection = true
        view.addSubview(seasonsCollectionView)
        
        tempFilters = [freezing, cold, chilly, moderate, warm, hot]
        tempsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        tempsCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        tempsCollectionView.dataSource = self
        tempsCollectionView.delegate = self
        tempsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tempsCollectionView.backgroundColor = UIColor.clear
        tempsCollectionView.showsVerticalScrollIndicator = false
        tempsCollectionView.showsHorizontalScrollIndicator = false
        tempsCollectionView.allowsMultipleSelection = true
        view.addSubview(tempsCollectionView)
        
        weatherFilters = [thunderstorm, drizzle, rain, snow, clear, clouds]
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        weatherCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.backgroundColor = UIColor.clear
        weatherCollectionView.showsVerticalScrollIndicator = false
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.allowsMultipleSelection = true
        view.addSubview(weatherCollectionView)

        // outfits
        // GET LIKED OUTFITS ONLY!
        outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
        print(outfits)
        let outfitsLayout = UICollectionViewFlowLayout()
        outfitsLayout.scrollDirection = .vertical
        outfitsLayout.minimumInteritemSpacing = padding
        outfitsLayout.minimumLineSpacing = padding

        outfitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: outfitsLayout)
        outfitsCollectionView.register(OutfitsCollectionViewCell.self, forCellWithReuseIdentifier: outfitsCellReuseIdentifier)
        outfitsCollectionView.dataSource = self
        outfitsCollectionView.delegate = self
        outfitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        outfitsCollectionView.backgroundColor = UIColor.clear
        outfitsCollectionView.showsVerticalScrollIndicator = false
        outfitsCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(outfitsCollectionView)
       
        setupConstraints()
        // outfitsCollectionView.reloadData()

    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            searchBar.heightAnchor.constraint(equalToConstant: 40)
//        ])
        
        // instructions label
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 50),
            instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
       
        // filter collection view: seasons
        NSLayoutConstraint.activate([
            seasonsCollectionView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: padding),
            seasonsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            seasonsCollectionView.heightAnchor.constraint(equalToConstant: 30),
            seasonsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        // filter collection view: temps
        NSLayoutConstraint.activate([
            tempsCollectionView.topAnchor.constraint(equalTo: seasonsCollectionView.bottomAnchor, constant: padding),
            tempsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tempsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            tempsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        // filter collection view: weather conditions
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: tempsCollectionView.bottomAnchor, constant: padding),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 40),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
       
        // outfits collection view
        NSLayoutConstraint.activate([
            outfitsCollectionView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: padding),
            outfitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitsCollectionView.heightAnchor.constraint(equalToConstant: 650),
            outfitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outfitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LikedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.seasonsCollectionView {
            return seasonFilters.count
        }
        else if collectionView == self.tempsCollectionView {
            return tempFilters.count
        }
        else if collectionView == self.weatherCollectionView {
            return weatherFilters.count
        }
        else {
            return outfits.count
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.seasonsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: seasonFilters[indexPath.item])
            return cell
        }
        else if collectionView == self.tempsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: tempFilters[indexPath.item])
            return cell
        }
        else if collectionView == self.weatherCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: weatherFilters[indexPath.item])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: outfitsCellReuseIdentifier, for: indexPath) as! OutfitsCollectionViewCell
            cell.configure(outfit: outfits[indexPath.item])
            return cell
       }
    }
}

   
extension LikedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.seasonsCollectionView {
            let size = (collectionView.frame.width - 2 * padding) / 6.0
            return CGSize(width: size, height: 50)
        }
        else if collectionView == self.tempsCollectionView {
            let size = (collectionView.frame.width - 2 * padding) / 6.0
            return CGSize(width: size, height: 50)
        }
        else if collectionView == self.weatherCollectionView {
            let size = (collectionView.frame.width - 2 * padding) / 6.0
            return CGSize(width: size, height: 50)
        }
        else {
            let size = (collectionView.frame.width - 2 * padding) / 3.0
            return CGSize(width: size, height: 200)
        }
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.outfitsCollectionView {
            let outfit = outfits[indexPath.row]
            let outfitViewController = OutfitViewController(outfit: outfit)
            navigationController?.pushViewController(outfitViewController, animated: true)
        }
        
       // TODO: FILTER TAPPING SHIT AND SORTING
        else if collectionView == self.seasonsCollectionView {
            let filter = seasonFilters[indexPath.row]
            if !filter.didSelect {
                seasonFilters[indexPath.row].didSelect = true
                filtersPressed.append(seasonFilters[indexPath.row])
                print(filtersPressed)
                }
            else {
                seasonFilters[indexPath.row].didSelect = false
                let remove = seasonFilters[indexPath.row]
                filtersPressed.removeAll { $0.filterName == remove.filterName }
            }
            seasonsCollectionView.reloadData()
            // DISPLAY ONLY OUTFITS W FILTERS PRESSED
            var selectedOutfits: [Outfit] = []
            var selectedFilters: [String] = []
            for filter in filtersPressed {
                selectedFilters.append(filter.filterName.lowercased())
            }
            for outfit in outfits {
                for tag in outfit.weatherTags {
                    if selectedFilters.contains(tag){
                        selectedOutfits.append(outfit)
                    }
                }
            }
            outfits = selectedOutfits
            outfitsCollectionView.reloadData()
            
            // IF NO FILTER IS SELECTED
            if selectedFilters == [] {
                outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
                outfitsCollectionView.reloadData()
            }
        }
        else if collectionView == self.tempsCollectionView {
            let filter = tempFilters[indexPath.row]
            if !filter.didSelect {
                tempFilters[indexPath.row].didSelect = true
                filtersPressed.append(tempFilters[indexPath.row])
                print(filtersPressed)
                }
            else {
                tempFilters[indexPath.row].didSelect = false
                let remove = tempFilters[indexPath.row]
                filtersPressed.removeAll { $0.filterName == remove.filterName }
            }
            tempsCollectionView.reloadData()
            var selectedOutfits: [Outfit] = []
            var selectedFilters: [String] = []
            for filter in filtersPressed {
                // only get string before the space
                if let index = filter.filterName.firstIndex(of: " ") {
                    let firstPart = filter.filterName.prefix(upTo: index)
                    selectedFilters.append(String(firstPart).lowercased())
            }
            }
            for outfit in outfits {
                for tag in outfit.weatherTags {
                    if selectedFilters.contains(tag){
                        selectedOutfits.append(outfit)
                    }
                }
            }
            outfits = selectedOutfits
            outfitsCollectionView.reloadData()
            
            // IF NO FILTER IS SELECTED
            if selectedFilters == [] {
                outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
                outfitsCollectionView.reloadData()
            }
        }
        else if collectionView == self.weatherCollectionView {
            let filter = weatherFilters[indexPath.row]
            if !filter.didSelect {
                weatherFilters[indexPath.row].didSelect = true
                filtersPressed.append(weatherFilters[indexPath.row])
                print(filtersPressed)
                }
            else {
                weatherFilters[indexPath.row].didSelect = false
                let remove = weatherFilters[indexPath.row]
                filtersPressed.removeAll { $0.filterName == remove.filterName }
            }
            weatherCollectionView.reloadData()
            var selectedOutfits: [Outfit] = []
            var selectedFilters: [String] = []
            for filter in filtersPressed {
                selectedFilters.append(filter.filterName.lowercased())
            }
            for outfit in outfits {
                for tag in outfit.weatherTags {
                    if selectedFilters.contains(tag){
                        selectedOutfits.append(outfit)
                    }
                }
            }
            outfits = selectedOutfits
            outfitsCollectionView.reloadData()
            
            // IF NO FILTER IS SELECTED
            if selectedFilters == [] {
                outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
                outfitsCollectionView.reloadData()
            }
        }
    }
}

