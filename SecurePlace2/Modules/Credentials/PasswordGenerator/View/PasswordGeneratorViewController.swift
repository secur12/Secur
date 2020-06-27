//
//  SSPasswordGeneratorViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class PasswordGeneratorViewController: BaseViewController {

    private var passwordLabel: UILabel = UILabel()
    private var passwordTextField: SSTextField = SSTextField(placeholder: "", type: .default)
    private var passwordGenerateButton: UIButton = UIButton()
    private var passwordCopyButton: UIButton = UIButton()
    private var paramsTableView: UITableView = UITableView()

    private var lengthSlider = UISlider()
    private var lengthSliderValue = UILabel()

    var presenter: PasswordGeneratorPresenterProtocol!

    var azSmallParamBool = false
    var azBigParamBool = false
    var numbersParamBool = false
    var charactersParamBool = false

    let azSmallParamString = "abcdefghijklmnopqrstuvwxyz"
    let azBigParamString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let numbersParamString = "0123456789"
    let charactersParamString = "!$%@#"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {
        self.view.backgroundColor = Colors.lightBlurBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Generator"

        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordGenerateButton)
        view.addSubview(paramsTableView)
        view.addSubview(lengthSlider)
        view.addSubview(lengthSliderValue)
        passwordTextField.addSubview(passwordCopyButton)

        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        passwordLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.withRatio())
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.clipsToBounds = true
        passwordTextField.isUserInteractionEnabled = false
        passwordTextField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(passwordLabel.snp.left)
            make.top.equalTo(passwordLabel.snp.bottom).offset(8.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
            make.height.equalTo(43.withRatio())
        }

        passwordCopyButton.setImage(UIImage(named: "copyCredential"), for: .normal)
        passwordCopyButton.addTarget(self, action: #selector(copyButtonPressed), for: .touchUpInside)
        passwordCopyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10.withRatio())
            make.centerY.equalToSuperview()
            make.height.equalTo(21.withRatio())
            make.width.equalTo(18.withRatio())
        }

        passwordGenerateButton.layer.cornerRadius = 8.withRatio()
        passwordGenerateButton.clipsToBounds = true
        self.passwordGenerateButton.setTitle("Generate", for: .normal)
        passwordGenerateButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        passwordGenerateButton.addTarget(self, action: #selector(didClickGeneratorButton), for: .touchUpInside)
        passwordGenerateButton.backgroundColor = Colors.brandBlue
        passwordGenerateButton.snp.makeConstraints { (make) in
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(53.withRatio())
        }

        lengthSliderValue.text = "Length: 8 characters"
        lengthSliderValue.font = UIFont.systemFont(ofSize: 16.withRatio(), weight: .semibold)
        lengthSliderValue.snp.makeConstraints { (make) in
            make.top.equalTo(passwordGenerateButton.snp.bottom).offset(17.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
        }

        lengthSlider.minimumValue = 8
        lengthSlider.maximumValue = 64
        lengthSlider.isContinuous = true
        lengthSlider.tintColor = Colors.brandBlue
        lengthSlider.value = 8
        lengthSlider.addTarget(self, action: #selector(lengthSliderValueChanged),for: .valueChanged)
        lengthSlider.snp.makeConstraints { (make) in
            make.top.equalTo(lengthSliderValue.snp.bottom).offset(5.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
            make.right.equalToSuperview().offset(-20.withRatio())
        }

        paramsTableView.delegate = self
        paramsTableView.dataSource = self
        paramsTableView.backgroundColor = Colors.lightBlurBackground
        paramsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(lengthSlider.snp.bottom).offset(33.withRatio())
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc func copyButtonPressed() {
        UIPasteboard.general.string = passwordTextField.text
    }

    @objc func didClickGeneratorButton() {
        let length = Int(lengthSlider.value)
        var charsString = ""
        if (numbersParamBool) {
            charsString+=numbersParamString
        }
        if (azSmallParamBool) {
            charsString+=azSmallParamString
        }
        if (azBigParamBool) {
            charsString+=azBigParamString
        }
        if(charactersParamBool) {
            charsString+=charactersParamString
        }
        passwordTextField.text = String((0..<length).map{ _ in charsString.randomElement()! })
    }

    @objc func lengthSliderValueChanged() {
        var currentValue = Int(lengthSlider.value)
        DispatchQueue.main.async {
            self.lengthSliderValue.text = "Length: \(currentValue) characters"
        }
    }
}

extension PasswordGeneratorViewController: UITableViewDelegate, UITableViewDataSource {

    @objc func numbersSwitchChanged(mySwitch: UISwitch) {
        self.numbersParamBool = numbersParamBool == true ? false : true
    }

    @objc func azSmallSwitchChanged(mySwitch: UISwitch) {
        self.azSmallParamBool = azSmallParamBool == true ? false : true
    }

    @objc func AZBigSwitchChanged(mySwitch: UISwitch) {
        self.azBigParamBool = azBigParamBool == true ? false : true
    }

    @objc func charactersSwitchChanged(mySwitch: UISwitch) {
        self.charactersParamBool = charactersParamBool == true ? false : true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if(indexPath.row == 0) {
            let uiswitch = UISwitch()
            uiswitch.addTarget(self, action: #selector(numbersSwitchChanged), for: UIControl.Event.valueChanged)
            cell.textLabel?.text = "0-9"
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryView = uiswitch
        } else if(indexPath.row == 1) {
            cell.textLabel?.text = "a-z"
            let uiswitch = UISwitch()
            uiswitch.addTarget(self, action: #selector(azSmallSwitchChanged), for: UIControl.Event.valueChanged)
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryView = uiswitch
        } else if(indexPath.row == 2) {
            cell.textLabel?.text = "A-Z"
            let uiswitch = UISwitch()
            uiswitch.addTarget(self, action: #selector(AZBigSwitchChanged), for: UIControl.Event.valueChanged)
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryView = uiswitch
        } else if(indexPath.row == 3) {
            cell.textLabel?.text = "!$%@#"
            let uiswitch = UISwitch()
            uiswitch.addTarget(self, action: #selector(charactersSwitchChanged), for: UIControl.Event.valueChanged)
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryView = uiswitch
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()

        if section == 0 {
            let masterPasswordLabel: UILabel = UILabel(text: "Parameters", font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: UIColor.black, textAlignment: .left, numberOfLines: 1)
            view.addSubview(masterPasswordLabel)
            masterPasswordLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(17.withRatio())
                make.left.equalToSuperview().offset(20.withRatio())
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-12.withRatio())
            }
            view.backgroundColor = Colors.lightBlurBackground
        }

        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()

        if section == 0 {
            let masterPasswordLabel: UILabel = UILabel(text: "Turn on this parameters depending on the website policy.\nTry to turn on as more parameters as you can.\nIt can help make your generated password stronger.", font: UIFont.systemFont(ofSize: 14, weight: .light), textColor: UIColor.black, textAlignment: .left, numberOfLines: 0)
            view.addSubview(masterPasswordLabel)
            masterPasswordLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
                make.top.equalToSuperview().offset(12.withRatio())
                make.bottom.equalToSuperview().offset(-21.withRatio())
            }
            view.backgroundColor = Colors.lightBlurBackground
        }
        return view
    }
}

extension PasswordGeneratorViewController: PasswordGeneratorViewProtocol { }
