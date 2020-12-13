//
//  PostingViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/8/20.
//

import UIKit

// how to put user selected image in?? idk set up constraints first

class PostingViewController: UIViewController {
    var vcTitle: UILabel!
    var instructions: UILabel!
    var filterCollectionView: UICollectionView!
    var closeButton: UIButton!
    var postButton: UIButton!
    var imageName: String?
    var outfitImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        vcTitle = UILabel()
        vcTitle.text = "New Post"
        vcTitle.translatesAutoresizingMaskIntoConstraints = false
        vcTitle.font = .boldSystemFont(ofSize: 20)
        view.addSubview(vcTitle)
        
        // outfitImage = UIImageView(image: UIImage(named: imageName!))
        outfitImage = UIImageView(image: UIImage(named: "clothes1.png"))
        outfitImage.translatesAutoresizingMaskIntoConstraints = false
        outfitImage.contentMode = .scaleAspectFit
        outfitImage.isHidden = false
        view.addSubview(outfitImage)
        
        instructions = UILabel()
        instructions.text = "Categorize your outfit!"
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.font = .systemFont(ofSize: 20)
        view.addSubview(instructions)
    }
    
    func setupConstraints() {
        // vc title constraints
        NSLayoutConstraint.activate([vcTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vcTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vcTitle.heightAnchor.constraint(equalToConstant: 40)])
        
        // image constraints
        NSLayoutConstraint.activate([outfitImage.topAnchor.constraint(equalTo: vcTitle.bottomAnchor, constant: 60),
            outfitImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            outfitImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            outfitImage.heightAnchor.constraint(equalToConstant: 400)])
        
        // instructions constraints
        NSLayoutConstraint.activate([instructions.topAnchor.constraint(equalTo: outfitImage.bottomAnchor, constant: 40),
            instructions.leadingAnchor.constraint(equalTo: outfitImage.leadingAnchor),
            instructions.heightAnchor.constraint(equalToConstant: 40)])
    }

}
