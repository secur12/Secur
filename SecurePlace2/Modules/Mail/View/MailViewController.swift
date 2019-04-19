//
//  testViewController.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit
import SnapKit

@objc enum EmailConttrollerType: Int {
    case signIn
    case signUp
    case PINChange
}

class MailViewController: BaseViewController, UITextFieldDelegate {

    var presenter: MailPresenterProtocol!
    private var emailImageView = UIImageView()
    private var emailLabel = UILabel()
    private var emailDescription = UILabel()
    private var emailTextField = SSTextField(placeholder: "Email")
    private var continueButton = UIButton()
    private var keyboardHeight = 0
    private var controllerType = EmailConttrollerType.signIn

    override func viewWillAppear(_ animated: Bool) {
        self.emailTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    private func createUI() {

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        self.view.addSubview(emailImageView)
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailDescription)
        self.view.addSubview(emailTextField)
        self.view.addSubview(continueButton)

        self.emailImageView.image = UIImage(named: "emailImage")
        self.emailImageView.contentMode = .scaleAspectFit

        self.emailLabel.font = UIFont.systemFont(ofSize: 37.withRatio(), weight: .bold)
        self.emailLabel.text = "Email"

        self.emailDescription.text = "Please, enter your email.\n We will send one-time code."
        self.emailDescription.font = UIFont.systemFont(ofSize: 18.withRatio(), weight: .light)
        self.emailDescription.textAlignment = .center
        self.emailDescription.numberOfLines = 2

        self.emailTextField.delegate = self
        self.emailTextField.keyboardType = .emailAddress

        self.continueButton.setTitle("Continue", for: .normal)
        self.continueButton.setTitleColor(Colors.textBlue, for: .normal)
        self.continueButton.setTitleColor(Colors.buttonBlue, for: .highlighted)
        self.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

        self.emailTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.continueButton.snp.top).offset(-19.withRatio())
            make.left.equalToSuperview().offset(16.withRatio())
            make.right.equalToSuperview().offset(-16.withRatio())
            make.height.equalTo(50.withRatio())
        }

        self.emailDescription.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.emailTextField.snp.top).offset(-28.withRatio())
            make.centerX.equalToSuperview()
        }

        self.emailLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.emailDescription.snp.top).offset(-18.withRatio())
            make.centerX.equalToSuperview()
        }

        self.emailImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.emailLabel.snp.top).offset(-12.withRatio())
            make.width.height.equalTo(72.withRatio())
        }

    }

    @objc func continueButtonPressed() {
        if (validateEmail(strEmail: emailTextField.text as! NSString)) {
            print (true)
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

            self.continueButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-self.keyboardHeight - 19)
                make.centerX.equalToSuperview()
            }
        }
    }

}
extension MailViewController: MailViewProtocol { }

extension CGFloat {

    func withRatio() -> CGFloat {
        return self * (UIScreen.main.bounds.width / 375)
    }
}

extension Double {

    func withRatio() -> CGFloat {
        return CGFloat(self) * (UIScreen.main.bounds.width / 375)
    }

}

extension Int {

    func withRatio() -> CGFloat {
        return CGFloat(self) * (UIScreen.main.bounds.width / 375)
    }
}
