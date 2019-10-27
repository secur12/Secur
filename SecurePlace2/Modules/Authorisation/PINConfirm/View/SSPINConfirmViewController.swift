//
//  SSPINConfirmViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

@objc enum PINConfirmModuleType: Int {
    case signIn
    case signUp
    case PINChange
}

class PINConfirmViewController: BaseViewController {

    private var PINSetupImageView = UIImageView()
    private var PINSetupLabel = SSTitleLabel(title: "Confirm PIN code")
    private var PINSetupDescription = SSDescriptionLabel(text: "Good, now enter your new PIN code again to confirm and save it.", containsBoldText: "", numberOfLines: 2)
    private var stackView = UIStackView()
    
    private var controllerType = PINConfirmModuleType.signIn
    var presenter: PINConfirmPresenterProtocol!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerType = self.presenter.getModuleType()
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
extension PINConfirmViewController: PINConfirmViewProtocol { }
