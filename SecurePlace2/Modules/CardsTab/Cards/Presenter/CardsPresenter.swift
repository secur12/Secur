//
//  CardsPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//
import Foundation
import KeychainAccess

class CardsPresenter: BasePresenter {

    weak var view: CardsViewProtocol?
    private var wireFrame: CardsWireFrameProtocol
    private var interactor: CardsInteractorProtocol
    private var provider = CardsDataProvider(realmWrapper: RealmWrapper())

    init(view: CardsViewProtocol, wireFrame: CardsWireFrameProtocol, interactor: CardsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension CardsPresenter: CardsPresenterProtocol {
    func deleteCard(model: CardModel, segment: Int) {
        self.provider.deleteCard(model) { (cards) in
            if let cards = cards {
                self.reloadData(segment: segment)
            }
        }
    }


    func reloadData(segment: Int) {
        self.fetchDataBySegmentIndex(index: segment)
    }

    func didClickAddCardButton() {
        self.wireFrame.presentAddCardViewController(from: self.view)
    }

    func viewLoaded(segment: Int) {
        self.fetchDataBySegmentIndex(index: segment)
    }

    private func fetchDataBySegmentIndex(index: Int) {
        switch (index) {
        case 0:
            self.fetchData(tableType: .credit)
        case 1:
            self.fetchData(tableType: .debit)
        default:
            self.view?.showOkAlertController(title: "Error", message: "Not yet realized", callback: nil)
        }
    }

    private func fetchData(tableType: TableType) {

        let keychain = Keychain(service: "com.secur.SecurInc")
        guard let privateKeyDecryptedData = keychain[data: "privateKeyDecryptedData"] else { return }

        switch (tableType) {
            case .credit:
                provider.getCards(ofType: "Credit") { (models, error) in
                    self.view?.insertCreditCurrencies(models: models ?? [])

            }

            case.debit:
                provider.getCards(ofType: "Debit") { (models, error) in

                    self.view?.insertDebitCurrencies(models: models ?? [])

            }
        }
    }
}
