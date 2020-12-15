//
//  OutfitViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class OutfitViewController: UIViewController {
    var outfit: Outfit!
    let outfitImageView = UIImageView()
    let weatherTags = UILabel()
    let saveIcon = UIImageView()
    let shareIcon = UIImageView()
    let likeButton = UIButton()
    var likedArray : [Outfit] = []
    
    init(outfit: Outfit) {
        super.init(nibName: nil, bundle: nil)
        self.outfit = outfit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        // RESET USER DEFAULTS TO TEST
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
        
        view.backgroundColor = .white
        title = "Photo"
        
//        if outfit.userPosted {
//            let rightBarButton = UIBarButtonItem(title: "Delete Post", style: UIBarButtonItem.Style.plain, target: self, action: #selector(OutfitViewController.myRightSideBarButtonItemTapped(_:)))
//                    self.navigationItem.rightBarButtonItem = rightBarButton
//            rightBarButton.image = UIImage(named: "trash_full.png")
//            rightBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
//        }
        
        // kingfisher stuff for later
        // let photoURL = URL(string: outfit.imageName)
        // this downloads the image asynchronously if it's not cached yet
        // outfitImageView.kf.setImage(with: photoURL)
        let str = outfit.imageName
        print(String(str.prefix(4)))
        if String(str.prefix(4)) == "data" {
//            print("suff")
//            print(String(str.suffix(from: str.index(str.startIndex, offsetBy: 4))))
            let imageData : Data! = Data(base64Encoded: String(str.suffix(from: str.index(str.startIndex, offsetBy: 4))), options: .ignoreUnknownCharacters)
            outfitImageView.image = UIImage(data: imageData)
        }
        else {
            guard let imageData = try? Data(contentsOf: URL(string: outfit.imageName)!) else {
                            return
                        }
            outfitImageView.image = UIImage(data: imageData)
        }
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
            likeButton.setImage(UIImage(named: "biglikedheart.png"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(named: "bigunlikedheart.png"), for: .normal)
        }
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.contentMode = .scaleAspectFill
        likeButton.layer.masksToBounds = true
        // when like button is pressed
        likeButton.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        view.addSubview(likeButton)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if outfit.userPosted {
            let rightBarButton = UIBarButtonItem(title: "Delete Post", style: UIBarButtonItem.Style.plain, target: self, action: #selector(OutfitViewController.myRightSideBarButtonItemTapped(_:)))
                    self.navigationItem.rightBarButtonItem = rightBarButton
            rightBarButton.image = UIImage(named: "trash_full.png")
            rightBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        }
        let str = outfit.imageName
        if String(str.prefix(4)) == "data" {
            let imageData : Data! = Data(base64Encoded: String(str.suffix(from: str.index(str.startIndex, offsetBy: 4))), options: .ignoreUnknownCharacters)
            outfitImageView.image = UIImage(data: imageData)
        }
        else {
        guard let imageData = try? Data(contentsOf: URL(string: outfit.imageName)!) else {
                        return
                    }
            outfitImageView.image = UIImage(data: imageData) }

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
            likeButton.setImage(UIImage(named: "biglikedheart.png"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(named: "bigunlikedheart.png"), for: .normal)
        }
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.contentMode = .scaleAspectFill
        likeButton.layer.masksToBounds = true
        // when like button is pressed
        likeButton.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        view.addSubview(likeButton)
        
//        // share icon
//        shareIcon.image = UIImage(named: "share.png")
//        shareIcon.translatesAutoresizingMaskIntoConstraints = false
//        shareIcon.contentMode = .scaleAspectFill
//        shareIcon.layer.masksToBounds = true
//        view.addSubview(shareIcon)
//
//        // download or save icon
//        saveIcon.image = UIImage(named: "download.png")
//        saveIcon.translatesAutoresizingMaskIntoConstraints = false
//        saveIcon.contentMode = .scaleAspectFill
//        saveIcon.layer.masksToBounds = true
//        view.addSubview(saveIcon)
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        let padding: CGFloat = 10
        
        // outfit image
        NSLayoutConstraint.activate([
            outfitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            outfitImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outfitImageView.heightAnchor.constraint(equalToConstant: 400),
            outfitImageView.widthAnchor.constraint(equalToConstant: 340),
        ])
        
        // weather tags
        NSLayoutConstraint.activate([
            weatherTags.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            weatherTags.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        ])
        
        // liked heart
        NSLayoutConstraint.activate([likeButton.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
//        // share icon
//        NSLayoutConstraint.activate([shareIcon.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
//            shareIcon.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -20)
//        ])
//
//        // save icon
//        NSLayoutConstraint.activate([saveIcon.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: padding),
//            saveIcon.trailingAnchor.constraint(equalTo: shareIcon.leadingAnchor, constant: -20)
//        ])
        
    }
    
    @objc func toggleLike() {
        // if liking outfit
        if !outfit.didLike {
            outfit.didLike = true
            let likedArray = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
            
            var newArray: [Outfit] = []
            newArray = likedArray
            newArray.append(outfit)
            
            UserDefaults.standard.setStructArray(newArray, forKey: "LikedOutfits")
            print(UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits"))
        }
        
        // if unliking outfit
        else if outfit.didLike{
            outfit.didLike = false
            var likedArray = UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits")
            likedArray.removeAll { $0.imageName == outfit.imageName }
            UserDefaults.standard.setStructArray(likedArray, forKey: "LikedOutfits")
            print(UserDefaults.standard.structArrayData(Outfit.self, forKey: "LikedOutfits"))
        }
        viewDidLoad()
    }
    
    // for post deletion
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!){
        // TO DO: HANDLE POST DELETION HERE
        let alert = UIAlertController(title: "Are you sure you want to delete your post?", message: "This action cannot be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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

