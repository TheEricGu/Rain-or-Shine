//
//  SettingEditViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/12/20.
//

import UIKit

class SettingEditViewController: UIViewController {

    weak var delegate: SettingsViewController?
    var settingName: String?
    var setSetting: String?

    var button: UIButton!
    var settingNameLabel: UILabel!
    var settingTextField: UITextField!
    
    init(delegate: SettingsViewController?, settingName: String?, setSetting: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
        self.settingName = settingName
        self.setSetting = setSetting
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        settingTextField = UITextField()
        settingTextField.translatesAutoresizingMaskIntoConstraints = false
        settingTextField.borderStyle = .roundedRect
        settingTextField.backgroundColor = .white
        settingTextField.textAlignment = .center
        settingTextField.text = setSetting
        settingTextField.font = .systemFont(ofSize: 20)
        settingTextField.clearsOnBeginEditing = true
        view.addSubview(settingTextField)
        
        settingNameLabel = UILabel()
        settingNameLabel.text = settingName
        settingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        settingNameLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(settingNameLabel)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)

        // When the button is pressed, dismiss this ModalViewController and change the button name
        button.addTarget(self, action: #selector(dismissViewControllerAndSaveText), for: .touchUpInside)
        view.addSubview(button)

        setupConstraints()
    }
    

    func setupConstraints() {
        // label constraints
        NSLayoutConstraint.activate([settingNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            settingNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            settingNameLabel.heightAnchor.constraint(equalToConstant: 20)])

         // textField constraints
        NSLayoutConstraint.activate([
            settingTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            settingTextField.leadingAnchor.constraint(equalTo: settingNameLabel.trailingAnchor, constant: 16),
            settingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            settingTextField.heightAnchor.constraint(equalToConstant: 20)
                    ])
        
        // button constraints
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: settingNameLabel.bottomAnchor, constant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)
                    ])
            }
        

    @objc func dismissViewControllerAndSaveText() {
        // If let statements can also chain boolean checks after them, like a normal if statement.
        if settingName == "Name: " {
            UserDefaults.standard.set(setSetting, forKey: "Name")
        }
        else if settingName == "Gender: " {
            UserDefaults.standard.set(setSetting, forKey: "Gender")
        }
        else if settingName == "Location: " {
            UserDefaults.standard.set(setSetting, forKey: "Location")
        }
        
        if let settingText = settingTextField.text, settingText != "" {
            if settingText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                let alertController = UIAlertController(title: "Alert", message: "You cannot change setting to an empty string.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                delegate?.saveNewInfo(newInfo: settingText, didSelectRowAt: (delegate?.settingsTableView.indexPathForSelectedRow)!)
            }
        }
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        dismiss(animated: true, completion: nil)
    }
}
