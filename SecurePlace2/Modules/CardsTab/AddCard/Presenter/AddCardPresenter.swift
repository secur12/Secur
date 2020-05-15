//
//  SSAddCardPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import Foundation
import UIKit

class AddCardPresenter: BasePresenter {

    weak var view: AddCardViewProtocol?
    private var wireFrame: AddCardWireFrameProtocol
    private var interactor: AddCardInteractorProtocol
    private var provider = CardsDataProvider(realmWrapper: RealmWrapper())

    init(view: AddCardViewProtocol, wireFrame: AddCardWireFrameProtocol, interactor: AddCardInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AddCardPresenter: AddCardPresenterProtocol {
    func didClickActionButton(cardNumber: String, expiryDate: String, cvvCode: String, cardHolder: String, type: String, bankName: String, paymentSystemString: String) {

        let colors = Colors.getRandomGradient()
        
        let cardModel = CardModel(id: 0, cardNumber: cardNumber, expiryDate: expiryDate, cvvCode: cvvCode, cardHolder: cardHolder, type: type, bankName: bankName, paymentSystem: paymentSystemString, topGradientColorHex: UIColor.init(cgColor: colors[0]).toHexString() , bottomGradientColorHex: UIColor.init(cgColor: colors[1]).toHexString())
        
        provider.saveCard(cardModel) { (cardModel) in
            if let cardModel = cardModel {
                DispatchQueue.main.async {
                    self.view?.popViewController()
                }
            } else {
                self.view?.showOkAlertController(title: "Error", message: "Error during card save", callback: nil)
            }
        }
    }
}
