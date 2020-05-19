//
//  AddCredentialViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class AddCredentialViewController: BaseViewController {

    var presenter: AddCredentialPresenterProtocol!
    
    private var topSeparator: UIView = UIView()

    private var nameLabel: UILabel = UILabel()
    private var nameTextField: SSTextField = SSTextField(placeholder: "Name", type: .default)

    private var serviceLabel: UILabel = UILabel()
    private var serviceTextField: SSTextField = SSTextField(placeholder: "Service", type: .default)
    private var servicePicker = UIPickerView()

    private var usernameLabel: UILabel = UILabel()
    private var usernameTextField: SSTextField = SSTextField(placeholder: "Username", type: .default)

    private var passwordLabel: UILabel = UILabel()
    private var passwordTextField: SSTextField = SSTextField(placeholder: "***************", type: .default)
    private var passwordGeneratorButton: UIButton = UIButton()
    private var passwordShowHideButton: UIButton = UIButton()

    private var urlPathLabel: UILabel = UILabel()
    private var urlPathTextField: SSTextField = SSTextField(placeholder: "Password", type: .default)

    private var actionButton: UIButton = UIButton()
    private var idToEdit = 0
    var passwordIsHidden = true
    var serviceData = ["Netflix", "PayPal", "Facebook", "eBay", "Twitter", "OTHER"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.hideKeyboardWhenTappedAround()
    }

    private func createUI() {

        view.backgroundColor = UIColor.white
        title = "Add account"

        view.addSubview(topSeparator)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(serviceLabel)
        view.addSubview(serviceTextField)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordGeneratorButton)
        view.addSubview(passwordShowHideButton)
        
        view.addSubview(urlPathLabel)
        view.addSubview(urlPathTextField)
        view.addSubview(actionButton)

        topSeparator.backgroundColor = Colors.lightGrey
        topSeparator.snp.makeConstraints { (make) in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
             make.left.equalToSuperview().offset(20.withRatio())
             make.height.equalTo(0.3.withRatio())
             make.right.equalToSuperview()
        }

        nameLabel.text = "Name"
        nameLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topSeparator.snp.left)
            make.top.equalTo(topSeparator.snp.bottom).offset(8.withRatio())
        }

        nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        serviceLabel.text = "Service"
        serviceLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        serviceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topSeparator.snp.left)
            make.top.equalTo(nameTextField.snp.bottom).offset(10.withRatio())
        }

        servicePicker.dataSource = self
        servicePicker.delegate = self
        serviceTextField.inputView = servicePicker
        serviceTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nameTextField.snp.left)
            make.top.equalTo(serviceLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        usernameLabel.text = "Username"
        usernameLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(serviceTextField.snp.left)
            make.top.equalTo(serviceTextField.snp.bottom).offset(10.withRatio())
        }

        usernameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel.snp.left)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(43.withRatio())
        }

        passwordShowHideButton.setImage(UIImage(named: "eye"), for: .normal)
        passwordShowHideButton.addTarget(self, action: #selector(didClickPasswordShowHideButton), for: .touchUpInside)
        passwordShowHideButton.snp.makeConstraints { (make) in
            make.right.equalTo(passwordTextField.snp.right).offset(-15.withRatio())
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.height.equalTo(20.withRatio())
            make.width.equalTo(20.withRatio())
        }

        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        passwordLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameTextField.snp.left)
            make.top.equalTo(usernameTextField.snp.bottom).offset(10.withRatio())
        }

        passwordTextField.isSecureTextEntry = true
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(passwordLabel.snp.left)
            make.top.equalTo(passwordLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        passwordGeneratorButton.layer.cornerRadius = 8.withRatio()
        passwordGeneratorButton.clipsToBounds = true
        self.passwordGeneratorButton.setTitle("Strong password generator", for: .normal)
        passwordGeneratorButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        passwordGeneratorButton.backgroundColor = Colors.brandBlue
        passwordGeneratorButton.snp.makeConstraints { (make) in
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(53.withRatio())
        }

        urlPathLabel.text = "URL Path"
        urlPathLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        urlPathLabel.snp.makeConstraints { (make) in
            make.left.equalTo(passwordGeneratorButton.snp.left)
            make.top.equalTo(passwordGeneratorButton.snp.bottom).offset(10.withRatio())
        }

        urlPathTextField.snp.makeConstraints { (make) in
            make.left.equalTo(urlPathLabel.snp.left)
            make.top.equalTo(urlPathLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        self.actionButton.backgroundColor = Colors.brandBlue
        self.actionButton.layer.cornerRadius = 8.withRatio()
        self.actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28.withRatio())
            make.left.equalToSuperview().offset(16.withRatio())
            make.right.equalToSuperview().offset(-16.withRatio())
            make.height.equalTo(46.withRatio())
        }
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddCredentialViewController: AddCredentialViewProtocol {

    @objc func didClickActionButton() {
        if (self.nameTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Account field name cannot be empty", callback: nil)
        } else if (self.serviceTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "You must select service", callback: nil)
        } else if (self.usernameTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Username field cannot be empty", callback: nil)
        } else if (self.passwordTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Password field cannot be empty", callback: nil)
        } else if (self.urlPathTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Service URL cannot be empty", callback: nil)
        } else {
            self.presenter.didClickActionButton(name: nameTextField.text ?? "", serviceLogoTitle: serviceTextField.text ?? "", service: serviceTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", urlPath: urlPathTextField.text ?? "")
        }
    }

    @objc func didClickEditButton() {
        if (self.nameTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Account field name cannot be empty", callback: nil)
        } else if (self.serviceTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "You must select service", callback: nil)
        } else if (self.usernameTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Username field cannot be empty", callback: nil)
        } else if (self.passwordTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Password field cannot be empty", callback: nil)
        } else if (self.urlPathTextField.text?.isEmpty == true) {
            self.showOkAlertController(title: "Error", message: "Service URL cannot be empty", callback: nil)
        } else {
            self.presenter.didClickEditButton(id: idToEdit, name: nameTextField.text ?? "", serviceLogoTitle: serviceTextField.text ?? "", service: serviceTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", urlPath: urlPathTextField.text ?? "")
        }
    }

    @objc func didClickPasswordShowHideButton() {
        self.passwordIsHidden = passwordIsHidden ? false : true
        self.passwordTextField.isSecureTextEntry = passwordIsHidden
    }

    func configure(model: CredentialModel?) {
        if let model = model {
            self.title = "Edit account"
            self.nameTextField.text = model.serviceTitleLabel
            self.serviceTextField.text = model.serviceLogoImageTitle
            self.usernameTextField.text = model.usernameLabel
            self.passwordTextField.text = model.password
            self.urlPathTextField.text = model.pathUrl
            self.actionButton.setTitle("Edit", for: .normal)
            self.actionButton.addTarget(self, action: #selector(didClickEditButton), for: .touchUpInside)
            self.idToEdit = model.id
        } else {
            self.actionButton.setTitle("Add", for: .normal)
            self.actionButton.addTarget(self, action: #selector(didClickActionButton), for: .touchUpInside)
        }
    }
}

extension AddCredentialViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (pickerView == servicePicker) {
            return serviceData.count
        } else {
            return 0
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if (pickerView == servicePicker) {
            return serviceData[row]
        } else {
            return nil
        }
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if (pickerView == servicePicker) {
            serviceTextField.text = serviceData[row]
        }
    }
}

extension AddCredentialViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


