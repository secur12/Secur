//
//  SSPreferencesViewController.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class PreferencesViewController: BaseViewController {

    var presenter: PreferencesPresenterProtocol!

    var settingsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {
        self.title = "Settings"

        self.view.addSubview(self.settingsTableView)

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = Colors.lightBlurBackground

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .none

        settingsTableView.backgroundColor = Colors.lightBlurBackground
        settingsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension PreferencesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @objc func switchChanged(mySwitch: UISwitch) {
        let defaults = UserDefaults.standard
        defaults.set(mySwitch.isOn, forKey: "biometricsAuthEnabled")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if(indexPath.section == 0) {
            cell.textLabel?.textColor = Colors.brandBlue
            cell.textLabel?.text = "Change Master password"
        } else if(indexPath.section == 1) {
            let defaults = UserDefaults.standard
            let ifBiometricAuthEnabled = defaults.bool(forKey: "biometricsAuthEnabled")
            let uiswitch = UISwitch()
            uiswitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
            uiswitch.setOn(ifBiometricAuthEnabled, animated: false)
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.text = "At launch"
            cell.accessoryView = uiswitch

        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()

        if section == 0 {
            let masterPasswordLabel: UILabel = UILabel(text: "Master password", font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: UIColor.black, textAlignment: .left, numberOfLines: 1)
            view.addSubview(masterPasswordLabel)
            masterPasswordLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(17.withRatio())
                make.left.equalToSuperview().offset(20.withRatio())
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-12.withRatio())
            }
            view.backgroundColor = Colors.lightBlurBackground
        } else if section == 1 {
            let masterPasswordLabel: UILabel = UILabel(text: "Biometric authentification", font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: UIColor.black, textAlignment: .left, numberOfLines: 1)
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
            let masterPasswordLabel: UILabel = UILabel(text: "Master password will be asked every time, when you open the application. Don’t tell it to anyone.", font: UIFont.systemFont(ofSize: 14, weight: .light), textColor: UIColor.black, textAlignment: .left, numberOfLines: 0)
            view.addSubview(masterPasswordLabel)
            masterPasswordLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
                make.top.equalToSuperview().offset(12.withRatio())
                make.bottom.equalToSuperview().offset(-21.withRatio())
            }
            view.backgroundColor = Colors.lightBlurBackground
        } else if section == 1 {
            let masterPasswordLabel: UILabel = UILabel(text: "You can use biometric authentification for additional security, when you open the app. We advise to enable this feauture.", font: UIFont.systemFont(ofSize: 14, weight: .light), textColor: UIColor.black, textAlignment: .left, numberOfLines: 0)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.presenter.showMasterPasswordChange()
        }
    }
}

extension PreferencesViewController: PreferencesViewProtocol { }
