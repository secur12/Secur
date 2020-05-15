//
//  OneTimeCodeViewController.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit
import SnapKit
import LBTATools

class OneTimeCodeViewController: BaseScrollViewController, UITextFieldDelegate {

    var presenter: OneTimeCodePresenterProtocol!
    
    private var oneTimeImageView = UIImageView()
    private var oneTimeLabel = SSTitleLabel(title: "One-time code")
    private var oneTimeDescription: SSDescriptionLabel!
    private var oneTimeTextField = SSTextField(placeholder: "Code", type: .numberPad)
    private var continueButton = SSContinueButton(title: "Continue")
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
                    oneTimeImageView,5,
                    oneTimeLabel,18,
                    oneTimeDescription,28,
                    oneTimeTextField,19,
                    continueButton,19])
        
        self.formContainerStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        self.oneTimeImageView.image = UIImage(named: "oneTime")
        self.oneTimeImageView.contentMode = .scaleAspectFit
        
        self.oneTimeTextField.delegate = self
        self.oneTimeTextField.autocorrectionType = .no
        self.oneTimeTextField.returnKeyType = .continue
        
        self.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

        self.oneTimeTextField.snp.makeConstraints { (make) in
            switch deviceType {
            case .phone:
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
            case .pad:
                make.left.equalTo(oneTimeDescription.snp.left)
                make.right.equalTo(oneTimeDescription.snp.right)
            default:
                make.left.equalToSuperview().offset(16.withRatio())
                make.right.equalToSuperview().offset(-16.withRatio())
            }
           
            make.height.equalTo(50.withRatio())
        }
        
        self.oneTimeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(72.withRatio())
        }
    }
    
    func clearEmailTextField() {
        self.oneTimeTextField.text = ""
    }
    
    @objc func continueButtonPressed() {
        self.presenter.didClickContinue(code: oneTimeTextField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.presenter.didClickContinue(code: textField.text ?? "")
        return true
    }
}

extension OneTimeCodeViewController: OneTimeCodeViewProtocol {
    
    func clearCodeTextField() {
        self.oneTimeTextField.text = ""
    }
    
    func setDescriptionTextWithEmail(descriptionText: String, email: String, numberOfLines: Int) {
        self.oneTimeDescription = SSDescriptionLabel(text: descriptionText, containsItalicText: email, numberOfLines: numberOfLines)
    }
    
}
