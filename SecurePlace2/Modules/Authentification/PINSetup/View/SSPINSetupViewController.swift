//
//  SSPINSetupViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

@objc enum PINSetupModuleType: Int {
    case signIn
    case signUp
    case PINChange
}

class PINSetupViewController: BaseViewController {

    var presenter: PINSetupPresenterProtocol!

    private var PINSetupImageView = UIImageView()
    private var PINSetupLabel = SSTitleLabel(title: "Setup PIN code")
    private var PINSetupDescription = SSDescriptionLabel(text: "Ok, now setup your PIN code.\n You will enter it every app launch.", containsBoldText: "", numberOfLines: 2)
    private var stackView = UIStackView()
    
    override func viewWillAppear(_ animated: Bool) {
        //self.emailTextField.becomeFirstResponder()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    private func createUI() {
        self.view.backgroundColor = UIColor.white
        
        self.stackView = UIStackView.viewsAndIntsToStack(viewsAndSpacings: [
            PINSetupImageView,12,
            PINSetupLabel,18,
            PINSetupDescription])
        
        self.PINSetupImageView.image = UIImage(named: "pinImage")
        self.PINSetupImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(stackView)
        
        self.PINSetupImageView.snp.makeConstraints { (make) in
            make.width.equalTo(168.withRatio())
            make.height.equalTo(41.withRatio())
        }
        
        self.stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(299)
            make.centerX.equalToSuperview()
        }
    }
}
extension PINSetupViewController: PINSetupViewProtocol { }
