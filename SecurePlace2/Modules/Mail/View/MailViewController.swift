//
//  testViewController.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit
import SnapKit

@objc enum EmailModuleType: Int {
    case signIn
    case signUp
    case PINChange
}

class MailViewController: BaseViewController, UITextFieldDelegate {

    var presenter: MailPresenterProtocol!
    
    private var emailImageView = UIImageView()
    private var emailLabel = SSTitleLabel(title: "Email")
    private var emailDescription: SSDescriptionLabel!
    private var emailTextField = SSTextField(placeholder: "Email", type: .emailAddress)
    private var continueButton = SSContinueButton(title: "Continue")
    private var stackView = UIStackView()
    
    private var keyboardHeight = 0
    private var controllerType = EmailModuleType.signIn

    override func viewWillAppear(_ animated: Bool) {
        self.emailTextField.becomeFirstResponder()
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerType = self.presenter.getModuleType()
        self.createUI()
    }

    private func createUI() {

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        self.setDescriptionTextWithModuleType()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        self.stackView = UIStackView.viewsAndIntsToStack(viewsAndSpacings: [
            emailImageView,10,
            emailLabel,18,
            emailDescription,28,
            emailTextField,19,
            continueButton,19])
        
        self.view.addSubview(stackView)
        
        self.emailImageView.image = UIImage(named: "emailImage")
        self.emailImageView.contentMode = .scaleAspectFit
        
        self.emailTextField.delegate = self
        self.emailTextField.autocorrectionType = .no
        
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

    @objc func continueButtonPressed() {
        if (validateEmail(strEmail: emailTextField.text as! NSString)) {
            
            switch controllerType {
            case .signUp:
                showUserAlreadyExists()
                self.presenter.signUpUser(with: emailTextField.text ?? "")
            case .signIn:
                self.presenter.signInUser(with: emailTextField.text ?? "")
            case .PINChange:
                self.presenter.resetPIN(with: emailTextField.text ?? "")
            }
            
        } else {
            self.emailTextField.text = ""
            let alert = UIAlertController(title: "Wrong format!", message: "Please enter a valid email adress", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func validateEmail (strEmail: NSString) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format: "SELF MATCHES [c]%@", emailRegex)
        return (emailText.evaluate(with: strEmail))
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = Int(keyboardRectangle.height)
            
            self.stackView.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-self.keyboardHeight)
                make.centerX.equalToSuperview()
                make.right.equalToSuperview()
                make.left.equalToSuperview()
            }
        }
    }
    
    func setDescriptionTextWithModuleType() {
        switch controllerType {
        case .signUp:
            self.emailDescription = SSDescriptionLabel(text: "Please, enter your email to Sign Up\n No verification required.", containsBoldText: "Sign Up", numberOfLines: 2)
        case .signIn:
            self.emailDescription = SSDescriptionLabel(text: "Please, enter your email to Sign In\n We will send one-time code.", containsBoldText: "Sign In", numberOfLines: 2)
        case .PINChange:
            self.emailDescription = SSDescriptionLabel(text: "Please, enter your email to reset PIN\n We will send one-time code.", containsBoldText: "reset PIN", numberOfLines: 2)
        }
    }
    
    //Sign Up methods
    func showUserAlreadyExists() {
        let alert = UIAlertController(title: "Dejavue?", message: "User with this email already exists.\n Do you want to Sign In ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
}

extension MailViewController: MailViewProtocol { }
