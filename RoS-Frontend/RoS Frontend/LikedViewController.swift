//
//  LikedViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class LikedViewController: UIViewController, UICollectionViewDelegate {
    private let searchBar = UISearchBar()
    var filterCollectionView: UICollectionView!
    var outfitsCollectionView: UICollectionView!
    
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let outfitsCellReuseIdentifier = "outfitsCellReuseIdentifier"
    
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
    
    // set up filter
    // TODO: DETERMINE FILTERS?
    let filter1 = Filter(filterName: "Autumn", didSelect: false)
    var filters: [Filter] = []
    
    // set up outfits
    // TODO: GET LIKED OUTFITS ONLY! 
    let outfit1 = Outfit(imageName: "clothes1.jpeg", weatherTags: ["winter", "cloudy"], didLike: true)
    var outfits: [Outfit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Liked Outfits"
        self.view.backgroundColor = UIColor.white
        //self.navigationController?.isNavigationBarHidden = true
        
        // search bar
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search liked outfits by tags"
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.949, alpha: 1)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        view.addSubview(searchBar)
        
        
        // filter
        filters = [filter1,filter1,filter1,filter1,filter1,filter1,filter1]
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .horizontal
        filterLayout.minimumInteritemSpacing = padding
        filterLayout.minimumLineSpacing = padding

        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .white
        filterCollectionView.showsVerticalScrollIndicator = false
        filterCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(filterCollectionView)

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
        outfitsCollectionView.showsVerticalScrollIndicator = false
        outfitsCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(outfitsCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // filter collection view
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        // outfits collection view
        NSLayoutConstraint.activate([
            outfitsCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: padding),
            outfitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitsCollectionView.heightAnchor.constraint(equalToConstant: 650),
            outfitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}

extension LikedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.filterCollectionView {
            return filters.count
        }
        else {
            return outfits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.filterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: filters[indexPath.item])
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
        if collectionView == self.filterCollectionView {
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
    }
}

