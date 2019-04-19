//
//  SSAuthorisationViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class AuthorisationViewController: BaseViewController, UIGestureRecognizerDelegate {

    var presenter: AuthorisationPresenterProtocol!
    private var logoImageView = UIImageView()
    private var starsImageView = UIImageView()
    private var dontHaveAccountLabel = UILabel()
    private var signUpLabel = UILabel()
    private var dontHaveSignUpStackView = UIStackView()
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
        if (sender == self.dontHaveSignUpStackView.gestureRecognizers?[0]) {
            self.presenter.switchToEmail(type: .signUp)
        } else {
            self.presenter.switchToEmail(type: .signIn)
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
        self.view.addSubview(dontHaveSignUpStackView)
        self.view.addSubview(signInButton)
        self.view.addSubview(descriptionLabel)

        self.logoImageView.image = UIImage(named: "logoBig")
        self.logoImageView.contentMode = .scaleAspectFit

        self.starsImageView.image = UIImage(named: "passStars")
        self.starsImageView.contentMode = .scaleAspectFit

        self.dontHaveAccountLabel.textColor = Colors.textWhite
        self.dontHaveAccountLabel.font = UIFont(name: "Avenir", size: 18.withRatio())
        self.dontHaveAccountLabel.text = "Don't have an account?"

        self.signUpLabel.textColor = Colors.textWhite
        self.signUpLabel.font = UIFont.boldSystemFont(ofSize: 18.withRatio())
        self.signUpLabel.text = "Sign Up"

        self.descriptionLabel.textColor = Colors.textWhite
        self.descriptionLabel.font = UIFont(name: "Avenir", size: 25.withRatio())
        self.descriptionLabel.text = "Secure place for your \nphotos, videos and \ndocuments"
        self.descriptionLabel.numberOfLines = 3

        dontHaveSignUpStackView.axis = .horizontal
        dontHaveSignUpStackView.distribution = .equalSpacing
        dontHaveSignUpStackView.alignment = .center
        dontHaveSignUpStackView.spacing = 2
        dontHaveSignUpStackView.translatesAutoresizingMaskIntoConstraints = false
        dontHaveSignUpStackView.addArrangedSubview(dontHaveAccountLabel)
        dontHaveSignUpStackView.addArrangedSubview(signUpLabel)
        let goToEmailTap = UITapGestureRecognizer(target: self, action: #selector(switchToEmail(sender:)))
        dontHaveSignUpStackView.addGestureRecognizer(goToEmailTap)
        dontHaveSignUpStackView.isUserInteractionEnabled = true

        self.signInButton.backgroundColor = UIColor.white
        self.signInButton.layer.opacity = 0.8
        self.signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 21.withRatio(), weight: .regular)
        self.signInButton.setTitleColor(Colors.darkBlue, for: .normal)
        self.signInButton.setTitle("Sign In", for: .normal)
        self.signInButton.layer.cornerRadius = 9
        self.signInButton.addTarget(self, action: #selector(switchToEmail(sender:)), for: .touchUpInside)

        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(36.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
            make.width.height.equalTo(self.view.snp.width).multipliedBy(0.45)
            make.height.equalTo(self.logoImageView.snp.width).multipliedBy(0.21)
        }

        self.starsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.41)
            make.width.equalTo(self.starsImageView.snp.height).multipliedBy(0.17)
        }

        self.dontHaveSignUpStackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-25)
            make.centerX.equalToSuperview()
        }

        self.signInButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.dontHaveSignUpStackView.snp.top).offset(-20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(58)
        }

        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(self.signInButton.snp.top).offset(-25)
        }

    }
}

extension AuthorisationViewController: AuthorisationViewProtocol { }
