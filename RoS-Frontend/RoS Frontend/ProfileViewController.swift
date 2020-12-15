//
//  ProfileViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView = UIView()
    var outfitsCollectionView: UICollectionView!
    let outfitsCellReuseIdentifier = "outfitsCellReuseIdentifier"
    
    let headerID = "Header" // for section header
    
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
    
    // TODO: USER POSTED OUTFITS ONLY??
    // set up outfits
    
    var outfits: [Outfit] = []

    override func viewDidLoad() {
        // self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "clouds.jpg")!)
        super.viewDidLoad()
        
        // nav bar
        navigationItem.title = UserDefaults.standard.string(forKey: "Name")

        let rightBarButton = UIBarButtonItem(title: "Add Post", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileViewController.myRightSideBarButtonItemTapped(_:)))
                self.navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.image = UIImage(named: "addicon.png")
        rightBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        
        let leftBarButton = UIBarButtonItem(title: "Settings", style: UIBarButtonItem.Style.done, target: self, action: #selector(ProfileViewController.myLeftSideBarButtonItemTapped(_:)))
                self.navigationItem.leftBarButtonItem = leftBarButton
        leftBarButton.image = UIImage(named: "settings.png")
        leftBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        
        // header
        let iconLayer = CALayer()
        let iconImage = UIImage(named: "profileicon.png")?.cgImage
        iconLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        iconLayer.contents = iconImage
        iconLayer.position = CGPoint(x: 212, y: 75)
        self.headerView.layer.addSublayer(iconLayer)
        
        let locLabelLayer = CATextLayer()
        let iconLabelAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .semibold),
            .foregroundColor: UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        ]
        locLabelLayer.string = NSAttributedString(string: UserDefaults.standard.string(forKey: "Location")!) 
        locLabelLayer.alignmentMode = .center
        locLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
        locLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        locLabelLayer.position = CGPoint(x: 212, y: 160)
        self.headerView.layer.addSublayer(locLabelLayer)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        // outfits
        outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "PostedOutfits")
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
        view.addSubview(outfitsCollectionView)
        
        outfitsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        let flow = outfitsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSize(width: 30,height: 30)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerView.layer.sublayers?.popLast()
        
        navigationItem.title = UserDefaults.standard.string(forKey: "Name")

        let rightBarButton = UIBarButtonItem(title: "Add Post", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileViewController.myRightSideBarButtonItemTapped(_:)))
                self.navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.image = UIImage(named: "addicon.png")
        rightBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        
        let leftBarButton = UIBarButtonItem(title: "Settings", style: UIBarButtonItem.Style.done, target: self, action: #selector(ProfileViewController.myLeftSideBarButtonItemTapped(_:)))
                self.navigationItem.leftBarButtonItem = leftBarButton
        leftBarButton.image = UIImage(named: "settings.png")
        leftBarButton.tintColor = UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        
        // header
        let iconLayer = CALayer()
        let iconImage = UIImage(named: "profileicon.png")?.cgImage
        iconLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        iconLayer.contents = iconImage
        iconLayer.position = CGPoint(x: 212, y: 75)
        self.headerView.layer.addSublayer(iconLayer)
        
        let locLabelLayer = CATextLayer()
        let iconLabelAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .semibold),
            .foregroundColor: UIColor(red: 0.04, green: 0.492, blue: 0.746, alpha: 1)
        ]
        locLabelLayer.string = NSAttributedString(string: UserDefaults.standard.string(forKey: "Location")!)
        locLabelLayer.alignmentMode = .center
        locLabelLayer.alignmentMode = CATextLayerAlignmentMode.center;
        locLabelLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        locLabelLayer.position = CGPoint(x: 212, y: 160)
        self.headerView.layer.addSublayer(locLabelLayer)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        // outfits
        outfits = UserDefaults.standard.structArrayData(Outfit.self, forKey: "PostedOutfits")
//        print(outfits)
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
        view.addSubview(outfitsCollectionView)
        
        outfitsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        let flow = outfitsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.headerReferenceSize = CGSize(width: 30,height: 30)
        
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
        
        // outfits collection view
        NSLayoutConstraint.activate([
            outfitsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            outfitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outfitsCollectionView.heightAnchor.constraint(equalToConstant: 650),
            outfitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outfitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    // for section header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var v : UICollectionReusableView! = nil
        if kind == UICollectionView.elementKindSectionHeader {
            v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
            if v.subviews.count == 0 {
                v.addSubview(UILabel(frame:CGRect(x: 0,y: 0,width: 150,height: 30)))
            }
            let lab = v.subviews[0] as! UILabel
            lab.text = "Your Posts"
            lab.textAlignment = .left
        }
        return v
}
    
    // for nav bar
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!){
        PostingHandler.shared.showPostingActionSheet(vc: self)
        }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!){
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
        }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outfits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: outfitsCellReuseIdentifier, for: indexPath) as! OutfitsCollectionViewCell
        cell.configure(outfit: outfits[indexPath.item])
        return cell
    }
}

    
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 2 * padding) / 3.0
        return CGSize(width: size, height: 200)
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let outfit = outfits[indexPath.row]
        let outfitViewController = OutfitViewController(outfit: outfit)
        navigationController?.pushViewController(outfitViewController, animated: true)
    }
}
