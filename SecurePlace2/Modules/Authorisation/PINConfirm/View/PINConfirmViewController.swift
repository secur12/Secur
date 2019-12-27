//
//  SSPINConfirmViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class PINConfirmViewController: BaseScrollViewController {

    var presenter: PINConfirmPresenterProtocol!
    
    private var PINSetupImageView = UIImageView()
    private var PINSetupLabel = SSTitleLabel(title: "Confirm PIN code")
    private var PINSetupDescription = SSDescriptionLabel(text: "Good, now enter your new PIN code \n again to confirm and save it.", containsBoldText: "", numberOfLines: 2)
    private var PINPasscodeView = SSPasscode()
    
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
        
        self.viewsAndIntsToStack(viewsAndSpacings: [
            PINSetupImageView,12,
            PINSetupLabel,18,
            PINSetupDescription,19,
            PINPasscodeView,25])
        
        self.PINSetupImageView.image = UIImage(named: "pinImage")
        self.PINSetupImageView.contentMode = .scaleAspectFit
        
        self.PINPasscodeView.didFinishedEnterCode = finishEnteringCode(_:)
        self.PINPasscodeView.stack.distribution = .fillEqually
        self.PINPasscodeView.stack.alignment = .center
        self.PINPasscodeView.stack.spacing = 26.withRatio()
        
        self.PINSetupImageView.snp.makeConstraints { (make) in
            make.width.equalTo(168.withRatio())
            make.height.equalTo(41.withRatio())
        }
        
        self.PINPasscodeView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(85)
                make.right.equalToSuperview().offset(-85)
                make.height.equalTo(44)
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
