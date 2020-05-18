//
//  CardCell.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class CredentialCell: UITableViewCell {

    private var serviceLogo: UIImageView = UIImageView()
    private var serviceTitleLabel: UILabel = UILabel()
    private var usernameLabel: UILabel = UILabel()
    private var topSeparator: UIView = UIView()
    private var copyButton: UIButton = UIButton()

    private var password: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {

        //self.makeShadow()
        self.selectionStyle = .none

        self.contentView.addSubview(serviceLogo)
        self.contentView.addSubview(serviceTitleLabel)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(topSeparator)
        self.contentView.addSubview(copyButton)

        serviceLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12.withRatio())
            make.left.equalToSuperview().offset(21.withRatio())
            make.bottom.equalToSuperview().offset(-12.withRatio())
            make.height.equalTo(35.withRatio())
            make.width.equalTo(97.withRatio())
        }

        serviceTitleLabel.font = UIFont.systemFont(ofSize: 14)
        serviceTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12.withRatio())
            make.left.equalTo(serviceLogo.snp.right).offset(8.withRatio())
        }

        usernameLabel.textColor = Colors.lightGrey
        usernameLabel.font = UIFont.systemFont(ofSize: 11)
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(serviceTitleLabel.snp.bottom)
            make.left.equalTo(serviceLogo.snp.right).offset(11.withRatio())
        }

        copyButton.setImage(UIImage(named: "copyCredential"), for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonPressed), for: .touchUpInside)
        copyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-21.withRatio())
            make.centerY.equalToSuperview()
            make.height.equalTo(21.withRatio())
            make.width.equalTo(18.withRatio())
        }

        topSeparator.backgroundColor = Colors.lightGrey
        topSeparator.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(0.3.withRatio())
            make.right.equalToSuperview()
        }
    }

    @objc func copyButtonPressed() {
        UIPasteboard.general.string = password
    }
}

extension CredentialCell {

    func display(_ model: CredentialModel) {

        self.serviceLogo.image = UIImage(named: model.serviceLogoImageTitle)
        self.serviceTitleLabel.text = model.serviceTitleLabel
        self.usernameLabel.text = model.usernameLabel
        self.password = model.password
    }
}
