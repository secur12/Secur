//
//  testViewController.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit
import SnapKit
import LBTATools

@objc enum EmailModuleType: Int {
    case signIn
    case signUp
    case PINChange
}

class MailViewController: BaseScrollViewController, UITextFieldDelegate {

    var presenter: MailPresenterProtocol!
    
    private var emailImageView = UIImageView()
    private var emailLabel = SSTitleLabel(title: "Email")
    private var emailDescription: SSDescriptionLabel!
    private var emailTextField = SSTextField(placeholder: "Email", type: .emailAddress)
    private var continueButton = SSContinueButton(title: "Continue")
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //self.emailTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    private func createUI() {

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    
        self.presenter.setDescriptionText()

        self.viewsAndIntsToStack(viewsAndSpacings: [
                    emailImageView,5,
                    emailLabel,18,
                    emailDescription,28,
                    emailTextField,19,
                    continueButton,19])
        
        self.formContainerStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        self.emailImageView.image = UIImage(named: "emailImage")
        self.emailImageView.contentMode = .scaleAspectFit
        
        self.emailTextField.delegate = self
        self.emailTextField.autocorrectionType = .no
        self.emailTextField.returnKeyType = .continue
        
        self.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

        self.emailTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.withRatio())
            make.right.equalToSuperview().offset(-16.withRatio())
            make.height.equalTo(50.withRatio())
        }
        
        self.emailImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(72.withRatio())
        }
    }
    
    func clearEmailTextField() {
        self.emailTextField.text = ""
    }
    
    @objc func continueButtonPressed() {
        self.presenter.didClickContinue(email: emailTextField.text ?? "")
    }
    
    func setDescriptionTextWithModuleType(text: String, boldText: String, numberOfLines: Int) {
        self.emailDescription = SSDescriptionLabel(text: text, containsBoldText: boldText, numberOfLines: numberOfLines)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.presenter.didClickContinue(email: emailTextField.text ?? "")
        return true
    }
}

extension MailViewController: MailViewProtocol { }
