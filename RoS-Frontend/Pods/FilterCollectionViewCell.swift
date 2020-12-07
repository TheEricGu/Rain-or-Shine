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
        contentView.addSubview(filterLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // filter label constraints
        NSLayoutConstraint.activate([filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor), filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    func configure(filter: Filter) {
        filterLabel.text = filter.filterName
        // probably something about toggling filter selection here later
    }
    
    func filterBy(tag: String) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
