//
//  SSPINConfirmViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class PINConfirmViewController: BaseViewController {

    var presenter: PINConfirmPresenterProtocol!
    
    private var PINSetupImageView = UIImageView()
    private var PINSetupLabel = SSTitleLabel(title: "Confirm PIN code")
    private var PINSetupDescription = SSDescriptionLabel(text: "Good, now enter your new PIN code \n again to confirm and save it.", containsBoldText: "", numberOfLines: 2)
    private var PINPasscodeView = SSPasscode()
    private var stackView = UIStackView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.PINPasscodeView.becomeFirstResponder()
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
            PINSetupDescription,19,
            PINPasscodeView])
        
        self.PINSetupImageView.image = UIImage(named: "pinImage")
        self.PINSetupImageView.contentMode = .scaleAspectFit
        
        self.PINPasscodeView.didFinishedEnterCode = finishEnteringCode(_:)
        
        self.view.addSubview(stackView)
        
        self.PINSetupImageView.snp.makeConstraints { (make) in
            make.width.equalTo(168.withRatio())
            make.height.equalTo(41.withRatio())
        }
        
        self.PINPasscodeView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(35)
                make.right.equalToSuperview().offset(-35)
                make.height.equalTo(44)
            }
        
        self.stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(299)
            make.centerX.equalToSuperview()
        }
    }
    
    func finishEnteringCode(_ code: String) {
        self.presenter.didFinishEnteringCode(code: code)
    }
    
}
extension PINConfirmViewController: PINConfirmViewProtocol {
    
    func clearPin() {
       self.PINPasscodeView.clearPin()
       self.PINPasscodeView.becomeFirstResponder()
    }
}
