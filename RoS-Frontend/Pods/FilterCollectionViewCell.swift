//
//  FilterCollectionViewCell.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/6/20.
//
import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    var filterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textAlignment = .center
        filterLabel.numberOfLines = 0
        contentView.addSubview(filterLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // filter label constraints
        NSLayoutConstraint.activate([filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            filterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    func configure(filter: Filter) {
        filterLabel.text = filter.filterName
        // TODO: probably something about toggling filter selection here
        if filter.didSelect {
            filterLabel.backgroundColor = UIColor(red: 0.925, green: 0.431, blue: 0.298, alpha: 1)
            filterLabel.textColor = .white
        }
        else {
            filterLabel.backgroundColor = .white
            filterLabel.textColor = .black
        }
    }
    
    func filterBy(tag: String) {
        // TODO? 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
