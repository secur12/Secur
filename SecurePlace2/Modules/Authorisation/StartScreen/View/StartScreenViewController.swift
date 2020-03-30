//
//  StartScreenViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class StartScreenViewController: BaseViewController, UIGestureRecognizerDelegate {

    var presenter: StartScreenPresenterProtocol!
    private var logoImageView = UIImageView()
    private var starsImageView = UIImageView()
    private var alreadyHaveAccountLabel = UILabel()
    private var signIn = UILabel()
    private var alreadyHaveSignIn = UIStackView()
    private var signInButton = UIButton()
    private var descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    override func viewWillAppear(_ animated: Bool) {
         navigationController?.navigationBar.isHidden = true
    }

    @objc func switchToEmail(sender: UITapGestureRecognizer? = nil) {
        if (sender == self.alreadyHaveSignIn.gestureRecognizers?[0]) {
            self.presenter.switchToEmail(type: .signIn)
        } else {
            self.presenter.switchToEmail(type: .signUp)
        }
    }

    private func createUI() {
        view.backgroundColor = .white

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [Colors.gradientLightBlue.cgColor, Colors.brandBlue.cgColor]

        self.view.layer.insertSublayer(gradient, at: 4)
        self.view.addSubview(logoImageView)
        self.view.addSubview(starsImageView)
        self.view.addSubview(alreadyHaveSignIn)
        self.view.addSubview(signInButton)
        self.view.addSubview(descriptionLabel)

        self.logoImageView.image = UIImage(named: "logoBig")
        self.logoImageView.contentMode = .scaleAspectFit

        self.starsImageView.image = UIImage(named: "passStars")
        self.starsImageView.contentMode = .scaleAspectFit

        self.alreadyHaveAccountLabel.textColor = Colors.textWhite
        self.alreadyHaveAccountLabel.font = UIFont(name: "Avenir", size: 18.withRatio())
        self.alreadyHaveAccountLabel.text = "Already have an account?"

        self.signIn.textColor = Colors.textWhite
        self.signIn.font = UIFont.boldSystemFont(ofSize: 18.withRatio())
        self.signIn.text = "Sign In"

        self.descriptionLabel.textColor = Colors.textWhite
        self.descriptionLabel.font = UIFont(name: "Avenir", size: 25.withRatio())
        self.descriptionLabel.text = "Secure place for your \nphotos, videos and \ndocuments"
        self.descriptionLabel.numberOfLines = 3

        alreadyHaveSignIn.axis = .horizontal
        alreadyHaveSignIn.distribution = .equalSpacing
        alreadyHaveSignIn.alignment = .center
        alreadyHaveSignIn.spacing = 2
        alreadyHaveSignIn.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveSignIn.addArrangedSubview(alreadyHaveAccountLabel)
        alreadyHaveSignIn.addArrangedSubview(signIn)
        let goToEmailTap = UITapGestureRecognizer(target: self, action: #selector(switchToEmail(sender:)))
        alreadyHaveSignIn.addGestureRecognizer(goToEmailTap)
        alreadyHaveSignIn.isUserInteractionEnabled = true

        self.signInButton.backgroundColor = UIColor.white
        self.signInButton.layer.opacity = 0.8
        self.signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 21.withRatio(), weight: .regular)
        self.signInButton.setTitleColor(Colors.darkBlue, for: .normal)
        self.signInButton.setTitle("Start", for: .normal)
        self.signInButton.layer.cornerRadius = 9.withRatio()
        self.signInButton.addTarget(self, action: #selector(switchToEmail(sender:)), for: .touchUpInside)

        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(55.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
            make.width.equalTo(174.withRatio())
            make.height.equalTo(43.withRatio())
        }

        self.starsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32.withRatio())
            make.right.equalToSuperview().offset(-35.withRatio())
            make.height.equalTo(167.withRatio())
            make.width.equalTo(35.withRatio())
        }

        self.alreadyHaveSignIn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-25.withRatio())
            make.centerX.equalToSuperview()
        }

        self.signInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.alreadyHaveSignIn.snp.top).offset(-20.withRatio())
            make.left.equalToSuperview().offset(16.withRatio())
            make.right.equalToSuperview().offset(-16.withRatio())
            make.height.equalTo(58.withRatio())
        }

        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.withRatio())
            make.bottom.equalTo(self.signInButton.snp.top).offset(-25.withRatio())
        }

    }
}

extension StartScreenViewController: StartScreenViewProtocol { }
