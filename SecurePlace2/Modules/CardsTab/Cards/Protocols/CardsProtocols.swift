//
//  SSCardsProtocols.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

enum TableType: String {
    case credit = "credit"
    case debit = "debit"
}

protocol CardsViewProtocol: class {
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func insertCreditCurrencies(models: [CardModel])
    func insertDebitCurrencies(models: [CardModel])
}

protocol CardsWireFrameProtocol: class {
    func presentAddCardViewController(from view: CardsViewProtocol?)
}

protocol CardsPresenterProtocol: class {
    func deleteCard(model: CardModel, segment: Int)
    func reloadData(segment: Int)
    func didClickAddCardButton()
    func viewLoaded(segment: Int)
}

protocol CardsInteractorProtocol: class { }
