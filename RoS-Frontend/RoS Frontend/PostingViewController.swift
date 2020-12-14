//
//  PostingViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/8/20.
//

import UIKit

// how to put user selected image in?? idk set up constraints first

class PostingViewController: UIViewController {
    weak var delegate: PostingHandler?
    var vcTitle: UILabel!
    var instructions: UILabel!
    var filterCollectionView: UICollectionView!
    var closeButton: UIButton!
    var postButton: UIButton!
    var image: UIImage!
    var outfitImage: UIImageView!
    
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
    
    // set up filter
    // TODO: DETERMINE FILTERS?
    let filter1 = Filter(filterName: "Autumn", didSelect: false)
    var filters: [Filter] = []

    init(delegate: PostingHandler?, image: UIImage!) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        // vc title
        vcTitle = UILabel()
        vcTitle.text = "New Post"
        vcTitle.translatesAutoresizingMaskIntoConstraints = false
        vcTitle.font = .boldSystemFont(ofSize: 20)
        vcTitle.textAlignment = .center
        view.addSubview(vcTitle)
        
        // put in image from photo library or camera here
        outfitImage = UIImageView(image: image)
        outfitImage.translatesAutoresizingMaskIntoConstraints = false
        outfitImage.contentMode = .scaleAspectFit
        outfitImage.isHidden = false
        view.addSubview(outfitImage)
        
        // instructions label
        instructions = UILabel()
        instructions.text = "Categorize your outfit!"
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.font = .systemFont(ofSize: 20)
        view.addSubview(instructions)
        
        // filter
        filters = [filter1,filter1,filter1,filter1]
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
        
        // close button
        closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "closebutton.png"), for: .normal)

        // when close button is pressed
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(closeButton)
        
        // post button
        postButton = UIButton()
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = .white
        postButton.setTitleColor(UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1), for: .normal)
        postButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        // When post button is pressed, dismiss this ModalViewController and post image
        postButton.addTarget(self, action: #selector(dismissViewControllerAndPost), for: .touchUpInside)
        view.addSubview(postButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // vc title constraints
        NSLayoutConstraint.activate([vcTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vcTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        // image constraints
        NSLayoutConstraint.activate([outfitImage.topAnchor.constraint(equalTo: vcTitle.bottomAnchor, constant: 60),
            outfitImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            outfitImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            outfitImage.heightAnchor.constraint(equalToConstant: 350)])
        
        // instructions constraints
        NSLayoutConstraint.activate([instructions.topAnchor.constraint(equalTo: outfitImage.bottomAnchor, constant: 20),
            instructions.leadingAnchor.constraint(equalTo: outfitImage.leadingAnchor, constant: 10)])
        
        // filter constraints
        NSLayoutConstraint.activate([filterCollectionView.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 30),
             filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50)])
        
        // close button constraints
        NSLayoutConstraint.activate([closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ])
        
        // post button constraints
        NSLayoutConstraint.activate([postButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            ])
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissViewControllerAndPost() {
        // TODO: POST IMAGE AND ADD IT TO API
        dismiss(animated: true, completion: nil)
    }
}

extension PostingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
        cell.configure(filter: filters[indexPath.item])
        return cell
    }
}

    
extension PostingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 2 * padding) / 5.0
        return CGSize(width: size, height: 50)
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: FILTER TAPPING SHIT AND SORTING
        if collectionView == self.filterCollectionView {
            var filter = filters[indexPath.row]
//            let cell = filterCollectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
            
            if !filter.didSelect {
                filters[indexPath.row].didSelect = true
                }
            else {
                filters[indexPath.row].didSelect = false
                // showResta.remove(at: indexPath.row)
                //filterPressed.remove(at: indexPath.row)
            }
        filterCollectionView.reloadData()
    }
        }
    }

