//
//  CardCell.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {

    private var container = UIView()

    private var bankLogo: UIImageView = UIImageView()
    private var paymentSystemLogo: UIImageView = UIImageView()

    private var cardNumberFirstPart: UILabel = UILabel()
    private var cardNumberSecondPart: UILabel = UILabel()
    private var cardNumberThirdPart: UILabel = UILabel()
    private var cardNumberFourthPart: UILabel = UILabel()

    private var cvvCodeLabel: UILabel = UILabel()
    private var cvvCodeValue: UILabel = UILabel()

    private var expiryDateLabel: UILabel = UILabel()
    private var expiryDateValue: UILabel = UILabel()

    private var cardHolderLabel: UILabel = UILabel()
    private var cardHolderValue: UILabel = UILabel()

    private var paymentSystemBackgroundLogo: UIImageView = UIImageView()

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

        container.layer.cornerRadius = 9
        container.layer.masksToBounds = true

        self.contentView.addSubview(container)

        let cardNumberContainer = UIView()
        container.addSubview(cardNumberContainer)

        container.addSubview(self.bankLogo)
        container.addSubview(self.paymentSystemLogo)
        cardNumberContainer.addSubview(self.cardNumberFirstPart)
        cardNumberContainer.addSubview(self.cardNumberSecondPart)
        cardNumberContainer.addSubview(self.cardNumberThirdPart)
        cardNumberContainer.addSubview(self.cardNumberFourthPart)
        container.addSubview(self.cvvCodeLabel)
        container.addSubview(self.cvvCodeValue)
        container.addSubview(self.expiryDateLabel)
        container.addSubview(self.expiryDateValue)
        container.addSubview(self.cardHolderLabel)
        container.addSubview(self.cardHolderValue)
        container.addSubview(self.paymentSystemBackgroundLogo)

        container.snp.makeConstraints { (make) in
            make.width.equalTo(341.withRatio())
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-17.withRatio())
        }

        paymentSystemLogo.contentMode = .scaleAspectFill
        paymentSystemLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32.withRatio())
            make.right.equalToSuperview().offset(-32.withRatio())
            make.width.lessThanOrEqualTo(56.withRatio())
            make.height.lessThanOrEqualTo(18.withRatio())
        }

        cardNumberFourthPart.textColor = UIColor.white
        cardNumberFourthPart.font = UIFont(name: "OCRAExtended", size: 23)
        cardNumberFourthPart.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        cardNumberThirdPart.textColor = UIColor.white
        cardNumberThirdPart.font = UIFont(name: "OCRAExtended", size: 23)
        cardNumberThirdPart.snp.makeConstraints { (make) in
            make.right.equalTo(cardNumberFourthPart.snp.left).offset(-23.withRatio())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        cardNumberSecondPart.textColor = UIColor.white
        cardNumberSecondPart.font = UIFont(name: "OCRAExtended", size: 23)
        cardNumberSecondPart.snp.makeConstraints { (make) in
            make.right.equalTo(cardNumberThirdPart.snp.left).offset(-23.withRatio())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        cardNumberFirstPart.textColor = UIColor.white
        cardNumberFirstPart.font = UIFont(name: "OCRAExtended", size: 23)
        cardNumberFirstPart.snp.makeConstraints { (make) in
            make.right.equalTo(cardNumberSecondPart.snp.left).offset(-23.withRatio())
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        cardNumberContainer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(paymentSystemLogo.snp.bottom).offset(36.withRatio())
        }

        expiryDateLabel.textColor = Colors.textLightGrey
        expiryDateLabel.text = "EXPIRES"
        expiryDateLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        expiryDateLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-37.withRatio())
            make.top.equalTo(cardNumberContainer.snp.bottom).offset(12.withRatio())
        }

        expiryDateValue.textColor = UIColor.white
        expiryDateValue.font = UIFont(name: "OCRAExtended", size: 23)
        expiryDateValue.snp.makeConstraints { (make) in
            make.top.equalTo(expiryDateLabel.snp.bottom).offset(4.withRatio())
            make.right.equalToSuperview().offset(-35.withRatio())
        }

        cvvCodeValue.textColor = UIColor.white
        cvvCodeValue.font = UIFont(name: "OCRAExtended", size: 23)
        cvvCodeValue.snp.makeConstraints { (make) in
            make.right.equalTo(expiryDateValue.snp.left).offset(-14.withRatio())
            make.bottom.equalTo(expiryDateValue.snp.bottom)
        }

        cvvCodeLabel.textColor = Colors.textLightGrey
        cvvCodeLabel.text = "CVV"
        cvvCodeLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        cvvCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cvvCodeValue.snp.left)
            make.bottom.equalTo(expiryDateLabel.snp.bottom)
        }

        cardHolderLabel.textColor = Colors.textLightGrey
        cardHolderLabel.text = "CARD HOLDER"
        cardHolderLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        cardHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(expiryDateValue.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(35)
        }

        cardHolderValue.textColor = UIColor.white
        cardHolderValue.font = UIFont(name: "OCRAExtended", size: 18)
        cardHolderValue.snp.makeConstraints { (make) in
            make.top.equalTo(cardHolderLabel.snp.bottom).offset(4.withRatio())
            make.right.equalTo(expiryDateValue.snp.right)
            make.left.equalTo((cardHolderLabel.snp.left))
            make.bottom.equalToSuperview().offset(-21.withRatio())
        }
    }

    private func makeShadow() {
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 9.0
    }
}

extension CardCell {
    func display(_ model: CardModel) {
//
//        let gradient = CAGradientLayer()
//        gradient.frame = container.bounds
//        self.gradient.colors = Colors.getRandomGradient()
//        //[UIColor.init(hexString: model.topGradientColorHex).cgColor, UIColor.init(hexString: model.bottomGradientColorHex).cgColor]
//        self.container.layer.insertSublayer(self.gradient, at: 0)
        self.container.backgroundColor = UIColor.init(hexString: model.topGradientColorHex)

        self.bankLogo.image = UIImage(named: model.bankName)

        if(model.paymentSystem == "visa") {
            self.paymentSystemLogo.image = UIImage(named: "visaWhite")
        } else {
            self.paymentSystemLogo.image = UIImage(named: model.paymentSystem)
        }

        let cardNumberArray = model.cardNumber.split{$0 == " "}.map(String.init)

        self.cardNumberFirstPart.text = cardNumberArray[0]
        self.cardNumberSecondPart.text = cardNumberArray[1]
        self.cardNumberThirdPart.text = cardNumberArray[2]
        self.cardNumberFourthPart.text = cardNumberArray[3]
        self.cvvCodeValue.text = model.cvvCode
        self.expiryDateValue.text = model.expiryDate
        self.cardHolderValue.text = model.cardHolder
    }
}
