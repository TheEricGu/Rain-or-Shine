//
//  OutfitsCollectionViewCell.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

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
        contentView.addSubview(outfitImageView)
        
        weatherTags = UILabel()
        weatherTags.translatesAutoresizingMaskIntoConstraints = false
        weatherTags.font = .systemFont(ofSize: 10)
        contentView.addSubview(weatherTags)
        
        likedHeart = UIImageView()
        likedHeart.translatesAutoresizingMaskIntoConstraints = false
        likedHeart.contentMode = .scaleAspectFill
        likedHeart.layer.masksToBounds = true
        contentView.addSubview(likedHeart)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        // image view constraints
        NSLayoutConstraint.activate([
            outfitImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outfitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outfitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outfitImageView.heightAnchor.constraint(equalToConstant: 150),
            outfitImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        // weather tags label constraints
        NSLayoutConstraint.activate([weatherTags.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor),
            weatherTags.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherTags.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        // liked heart image view constraints
        NSLayoutConstraint.activate([likedHeart.topAnchor.constraint(equalTo: outfitImageView.bottomAnchor, constant: 2),
            likedHeart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
    
    func configure(outfit: Outfit) {
        outfitImageView.image = UIImage(named: outfit.imageName)
        
        weatherTags.text = "" 
        for tag in outfit.weatherTags{
            weatherTags.text! += "#" + tag + " "
            
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

