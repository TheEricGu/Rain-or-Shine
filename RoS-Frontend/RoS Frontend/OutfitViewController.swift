//
//  OutfitViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class OutfitViewController: UIViewController {
    private var outfit: Outfit!
    private let outfitImageView = UIImageView()
    private let weatherTags = UILabel()
    private let saveIcon = UIImageView()
    private let shareIcon = UIImageView()
    private let likedHeart = UIImageView()
    
    init(outfit: Outfit) {
        super.init(nibName: nil, bundle: nil)
        self.outfit = outfit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo"
        
        // kingfisher stuff for later
        // let photoURL = URL(string: outfit.imageName)
        // this downloads the image asynchronously if it's not cached yet
        // outfitImageView.kf.setImage(with: photoURL)
        outfitImageView.image = UIImage(named: outfit.imageName)
        outfitImageView.translatesAutoresizingMaskIntoConstraints = false
        outfitImageView.contentMode = .scaleAspectFill
        outfitImageView.layer.masksToBounds = true
        outfitImageView.layer.cornerRadius = 10
        view.addSubview(outfitImageView)
        
        // weather tags
        weatherTags.text = ""
        for tag in outfit.weatherTags{
            weatherTags.text! += "#" + tag + " "
        }
        weatherTags.translatesAutoresizingMaskIntoConstraints = false
        weatherTags.numberOfLines = 0
        weatherTags.font = .boldSystemFont(ofSize: 20)
        view.addSubview(weatherTags)
        
        // liked heart
        if outfit.didLike {
            likedHeart.image = UIImage(named: "biglikedheart.png")
        }
        else {
            likedHeart.image = UIImage(named: "bigunlikedheart.png")
        }
        likedHeart.translatesAutoresizingMaskIntoConstraints = false
        likedHeart.contentMode = .scaleAspectFill
        likedHeart.layer.masksToBounds = true
        view.addSubview(likedHeart)
        
        // share icon
        shareIcon.image = UIImage(named: "share.png")
        shareIcon.translatesAutoresizingMaskIntoConstraints = false
        shareIcon.contentMode = .scaleAspectFill
        shareIcon.layer.masksToBounds = true
        view.addSubview(shareIcon)
        
        // download or save icon
        saveIcon.image = UIImage(named: "download.png")
        saveIcon.translatesAutoresizingMaskIntoConstraints = false
        saveIcon.contentMode = .scaleAspectFill
        saveIcon.layer.masksToBounds = true
        view.addSubview(saveIcon)

        
        // getOutfit()
        setupConstraints()
        
    }

    private func setupConstraints() {
        
        let padding: CGFloat = 30
        
        // outfit image
        NSLayoutConstraint.activate([
            outfitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            outfitImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outfitImageView.heightAnchor.constraint(equalToConstant: 400),
            outfitImageView.widthAnchor.constraint(equalToConstant: 340)
        ])
        
        // weather tags
        NSLayoutConstraint.activate([
            weatherTags.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            weatherTags.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        ])
        
        // liked heart
        NSLayoutConstraint.activate([likedHeart.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            likedHeart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        // share icon
        NSLayoutConstraint.activate([shareIcon.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            shareIcon.trailingAnchor.constraint(equalTo: likedHeart.leadingAnchor, constant: -20)
        ])
        
        // save icon
        NSLayoutConstraint.activate([saveIcon.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            saveIcon.trailingAnchor.constraint(equalTo: shareIcon.leadingAnchor, constant: -20)
        ])
        
    }


//    private func getRestaurant() {
//        NetworkManager.getRestaurant(id: restaurant.id) { restaurant in
//            self.restaurant = restaurant
//            if let reviews = restaurant.reviews {
//                self.reviewLabel.text = reviews[0]
//                self.reviewContainerView.sizeToFit()
//            }
//        }
//}
}

