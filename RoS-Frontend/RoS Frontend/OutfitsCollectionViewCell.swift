//
//  OutfitsCollectionViewCell.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//
import Foundation
import UIKit

class OutfitsCollectionViewCell: UICollectionViewCell {
    var outfitImageView: UIImageView!
    var weatherTags: UILabel!
    var likedHeart: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        outfitImageView = UIImageView()
        outfitImageView.translatesAutoresizingMaskIntoConstraints = false
        outfitImageView.contentMode = .scaleAspectFill
        outfitImageView.layer.masksToBounds = true
        outfitImageView.layer.cornerRadius = 10
        contentView.addSubview(outfitImageView)
        
        // do not display weather tags in collection view cells 
//        weatherTags = UILabel()
//        weatherTags.translatesAutoresizingMaskIntoConstraints = false
//        weatherTags.font = .systemFont(ofSize: 10)
//        contentView.addSubview(weatherTags)
        
        likedHeart = UIImageView()
        likedHeart.translatesAutoresizingMaskIntoConstraints = false
        likedHeart.contentMode = .scaleAspectFill
        likedHeart.layer.masksToBounds = true
        contentView.addSubview(likedHeart)
        
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints() {
        
        // image view constraints
        NSLayoutConstraint.activate([
            outfitImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outfitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outfitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outfitImageView.heightAnchor.constraint(equalToConstant: 160),
            outfitImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
//        // weather tags label constraints
//        NSLayoutConstraint.activate([weatherTags.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor),
//            weatherTags.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            weatherTags.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        // liked heart image view constraints
        NSLayoutConstraint.activate([likedHeart.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: 2),
            likedHeart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    

    
    func configure(outfit: Outfit) {
//        outfitImageView.image = UIImage.imageWithData(outfit.imageName)
        
//        weatherTags.text = ""
//        for tag in outfit.weatherTags{
//            weatherTags.text! += "#" + tag + " "
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

        if outfit.didLike {
            likedHeart.image = UIImage(named: "likedheart.png")
        }
        else {
            likedHeart.image = UIImage(named: "unlikedheart.png")
        }
    }
    }
    
    func filterBy(tag: String) {
        
    }


