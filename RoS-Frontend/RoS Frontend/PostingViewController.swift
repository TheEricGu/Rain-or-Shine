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
    var seasonsCollectionView: UICollectionView!
    var tempsCollectionView: UICollectionView!
    var weatherCollectionView: UICollectionView!
    var closeButton: UIButton!
    var postButton: UIButton!
    var image: UIImage!
    var outfitImage: UIImageView!
    
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let padding: CGFloat = 4
    let headerHeight: CGFloat = 50
    
    // set up filter
    // TODO: DETERMINE FILTERS?
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
        seasonsCollectionView.backgroundColor = .white
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
        tempsCollectionView.backgroundColor = .white
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
        weatherCollectionView.backgroundColor = .white
        weatherCollectionView.showsVerticalScrollIndicator = false
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.allowsMultipleSelection = true
        view.addSubview(weatherCollectionView)
        
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
        NSLayoutConstraint.activate([seasonsCollectionView.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 30),
             seasonsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             seasonsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
             seasonsCollectionView.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([tempsCollectionView.topAnchor.constraint(equalTo: seasonsCollectionView.bottomAnchor, constant: 5),
             tempsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             tempsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
             tempsCollectionView.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([weatherCollectionView.topAnchor.constraint(equalTo: tempsCollectionView.bottomAnchor, constant: 5),
             weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
             weatherCollectionView.heightAnchor.constraint(equalToConstant: 50)])
        
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
        if collectionView == self.seasonsCollectionView{
            return seasonFilters.count
        }
        else if collectionView == self.tempsCollectionView{
            return tempFilters.count
        }
        else {
            return weatherFilters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.seasonsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: seasonFilters[indexPath.item])
            return cell
        }
        else if collectionView == self.tempsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: tempFilters[indexPath.item])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: weatherFilters[indexPath.item])
            return cell
            }
    }
}

    
extension PostingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.seasonsCollectionView{
            let size = (collectionView.frame.width - 2 * padding) / 4.0
            return CGSize(width: size, height: 50)
        }
        else if collectionView == self.tempsCollectionView{
            let size = (collectionView.frame.width - 2 * padding) / 6.0
            return CGSize(width: size, height: 50)
        }
        else {
            let size = (collectionView.frame.width - 2 * padding) / 6.0
            return CGSize(width: size, height: 50)
        }
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: FILTER TAPPING SHIT AND SORTING
        if collectionView == self.seasonsCollectionView {
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
        }

        if collectionView == self.tempsCollectionView {
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
        }
        
        else {
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
        }
        }
}

