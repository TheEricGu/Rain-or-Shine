//
//  SettingsViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/8/20.
//

import UIKit

protocol SaveNewInfoDelegate: class {
    func saveNewInfo(newInfo: String?, didSelectRowAt indexPath: IndexPath)
}

class SettingsViewController: UIViewController {
    var settingsTableView: UITableView!
    
    let reuseIdentifier = "settingsCellReuse"
    let cellHeight: CGFloat = 50
    
    let gender = Settings(name: "Gender: ", option: "Female")
    let location = Settings(name: "Location: ", option: "Ithaca, NY")
    
    var settings: [Settings]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        self.view.backgroundColor = UIColor.white
        settings = [gender, location]
        
        settingsTableView = UITableView()
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(settingsTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
    // Setup the constraints for our views
        NSLayoutConstraint.activate([
                settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        let setting = settings[indexPath.row]
        cell.configure(for: setting)
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        let editSettingVC = SettingEditViewController(delegate: self, settingName: setting.name, setSetting: setting.option)
        self.present(editSettingVC, animated: true, completion: nil)
    }
}

extension SettingsViewController: SaveNewInfoDelegate {
    func saveNewInfo(newInfo: String?, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        setting.option = newInfo!
        settingsTableView.reloadData()
    }
}