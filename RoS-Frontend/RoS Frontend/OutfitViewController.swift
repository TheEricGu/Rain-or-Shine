//
//  OutfitViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class OutfitViewController: UIViewController {
    var outfitImageView: UIImageView!
    var weatherTags: UILabel!
    var saveIcon: UIImageView!
    var shareIcon: UIImageView!
    var likedHeart: UIImageView!
    weak var delegate: outfitDelegate?
    
    init(delegate: outfitDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
