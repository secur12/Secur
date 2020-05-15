//
//  SSPrivateKeyViewController.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class PrivateKeyViewController: BaseScrollViewController {

    var presenter: PrivateKeyPresenterProtocol!
    private var privateKeyImageView = UIImageView()
    private var privateKeyLabel = SSTitleLabel(title: "Private key")
    private var privateKeyDescription = SSDescriptionLabel(text: "Write this key on paper and hide.\nUse it to recover Master password.", containsBoldText: "", numberOfLines: 2)
    private var privateKeyValue: SSDescriptionLabel?
    private var continueButton = SSContinueButton(title: "Continue")
    private var privateKey = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.privateKey = self.privateKey.randomString(length: 20)
        self.createUI()
    }

    private func createUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        let separatedPrivateKey = self.privateKey.inserting(separator: "-", every: 4)
        self.privateKeyValue = SSDescriptionLabel(text: separatedPrivateKey, containsBoldText: separatedPrivateKey, numberOfLines: 2)
        
        self.viewsAndIntsToStack(viewsAndSpacings: [
            privateKeyImageView,5,
            privateKeyLabel,18,
            privateKeyDescription,28,
            privateKeyValue,19,
            continueButton,19])

        self.formContainerStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: 0)

        self.privateKeyImageView.image = UIImage(named: "oneTime")
        self.privateKeyImageView.contentMode = .scaleAspectFit

        self.privateKeyDescription.textColor = UIColor.red

        self.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

        self.privateKeyImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(72.withRatio())
        }
    }

    @objc func continueButtonPressed() {
        self.presenter.didClickContinue(privateKey: self.privateKey)
    }
}
extension PrivateKeyViewController: PrivateKeyViewProtocol { }
