//
//  SSMasterPasswordSetupViewController.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class MasterPasswordSetupViewController: BaseScrollViewController, UITextFieldDelegate {

    var presenter: MasterPasswordSetupPresenterProtocol!
    private var masterPasswordImageView = UIImageView()
    private var masterPasswordSetupLabel = SSTitleLabel(title: "Master password")
    private var masterPasswordSetupDescription = SSDescriptionLabel(text: "", containsBoldText: "", numberOfLines: 7)
    private var masterPasswordTextField = SSTextField(placeholder: "Master password", type: .default)
    private var continueButton = SSContinueButton(title: "Continue")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad()
    }

    private func createUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white

        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        self.viewsAndIntsToStack(viewsAndSpacings: [
            masterPasswordImageView,5,
            masterPasswordSetupLabel,18,
            masterPasswordSetupDescription,28,
            masterPasswordTextField,19,
            continueButton,19])

        self.formContainerStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)

        self.masterPasswordImageView.image = UIImage(named: "masterPassword")
        self.masterPasswordImageView.contentMode = .scaleAspectFit

        self.masterPasswordTextField.delegate = self
        self.masterPasswordTextField.autocorrectionType = .no
        self.masterPasswordTextField.returnKeyType = .continue

        self.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

        self.masterPasswordTextField.snp.makeConstraints { (make) in
            switch deviceType {
            case .phone:
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
            case .pad:
                make.left.equalTo(masterPasswordSetupDescription.snp.left)
                make.right.equalTo(masterPasswordSetupDescription.snp.right)
            default:
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
            }

            make.height.equalTo(50.withRatio())
        }

        self.masterPasswordImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(72.withRatio())
        }
    }

    func clearEmailTextField() {
        self.masterPasswordTextField.text = ""
    }

    @objc func continueButtonPressed() {
        self.presenter.didClickContinue(password: masterPasswordTextField.text ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.presenter.didClickContinue(password: masterPasswordTextField.text ?? "")
        return true
    }
}
extension MasterPasswordSetupViewController: MasterPasswordSetupViewProtocol {
    func passwordNotComplex() {
        self.masterPasswordTextField.text = ""
        showOkAlertController(title: "Try gain", message: "Password is not too complex.\n Try password with length more than 7 characters")
    }

    func setupSetupMasterTexts() {
        masterPasswordSetupDescription.text = "Setup your Master password.\nIt must not be so simple and minimum 8 characters length.\nYou must to remember it!"
    }

    func setupLaunchInputTexts() {
        masterPasswordSetupDescription.text = "Type your Master password,please"
    }
}
