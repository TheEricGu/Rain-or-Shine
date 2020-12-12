//
//  SettingsTableViewCell.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/12/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    var settingNameLabel: UILabel!
    var settingOptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        settingNameLabel = UILabel()
        settingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        settingNameLabel.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(settingNameLabel)

        settingOptionLabel = UILabel()
        settingOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        settingOptionLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(settingOptionLabel)

        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        let padding: CGFloat = 10
        let labelHeight: CGFloat = 30

        
        NSLayoutConstraint.activate([
            settingNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            settingNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            settingNameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])

        NSLayoutConstraint.activate([
            settingOptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            settingOptionLabel.leadingAnchor.constraint(equalTo: settingNameLabel.trailingAnchor, constant: padding),
            settingOptionLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
    }

    func configure(for setting: Settings) {
        settingNameLabel.text = setting.name
        settingOptionLabel.text = setting.option
    }

}
