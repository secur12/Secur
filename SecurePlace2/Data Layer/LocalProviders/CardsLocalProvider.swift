//
//  CardsDataProvider.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 30/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

protocol CardsLocalProviderProtocol {
    func getCards(ofType: String, _ completion: (([CardModel]?, Error?) -> Void)?)
    func getCard(id: Int, _ completion: ((CardModel?, Error?) -> Void)?)
    func deleteCard(_ card: CardModel, completion: (([CardModel]?) -> Void)?)
    func saveCard(_ card: CardModel, completion: ((CardModel?) -> Void)?)
    func editCard(_ card: CardModel, completion: ((Bool?) -> Void)?)
}

class CardsLocalProvider {

    private let realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }
}

extension CardsLocalProvider: CardsLocalProviderProtocol {

    func getCards(ofType: String, _ completion: (([CardModel]?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let allRlmObjects = realm.objects(CardRealmModel.self)

            if allRlmObjects.count > 0 {

                let filteredRlmObjects = allRlmObjects.filter {
                    $0.type == ofType
                }

            if filteredRlmObjects.count > 0 {
                var models = [CardModel]()
                filteredRlmObjects.forEach {
                    models.append($0.getModel())
                }
                completion?(models, nil)
            } else {
                completion?(nil, NSError())
            }
        } else {
            completion?(nil, NSError())
        }
        }
    }

    func getCard(id: Int, _ completion: ((CardModel?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObject = realm.object(ofType: CardRealmModel.self, forPrimaryKey: id)
            completion?(rlmObject?.getModel(), nil)
        }
    }

    func deleteCard(_ card: CardModel, completion: (([CardModel]?) -> Void)?) {
        var models = [CardModel]()
        self.realmWrapper.writeOperationAsync( { (realm) in
            if let rlmObject = realm.object(ofType: CardRealmModel.self, forPrimaryKey: card.id) {
                realm.delete(rlmObject)
            }
            let rlmObjects = realm.objects(CardRealmModel.self)
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models)
        }, callback: nil)
    }

    func saveCard(_ card: CardModel, completion: ((CardModel?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let realmObject = CardRealmModel.convert(from: card)
            realmObject.id = realmObject.incrementID()
            realm.add(realmObject)
            completion?(realmObject.getModel())
        }, callback: nil)
    }

    func editCard(_ card: CardModel, completion: ((Bool?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let cards = realm.objects(CardRealmModel.self).filter("id == \(card.id)")

            if let realmCard = cards.first {
                do {
                    try realm.write {
                    realmCard.cardNumber = card.cardNumber
                    realmCard.expiryDate = card.expiryDate
                    realmCard.cvvCode = card.cvvCode
                    realmCard.cardHolder = card.cardHolder
                    realmCard.type = card.type
                    realmCard.bankName = card.bankName
                    realmCard.paymentSystem = card.paymentSystem
                    }
                    completion?(true)
                } catch {
                    completion?(false)
                }
            }

        }, callback: nil)
    }

}
