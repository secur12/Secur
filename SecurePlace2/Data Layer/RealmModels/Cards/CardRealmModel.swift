//
//  CardModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 01/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import RealmSwift

class CardRealmModel: Object {

    @objc dynamic var id: Int = Int.min
    @objc dynamic var cardNumber: String = ""
    @objc dynamic var expiryDate: String = ""
    @objc dynamic var cvvCode: String = ""
    @objc dynamic var cardHolder: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var bankName: String = ""
    @objc dynamic var paymentSystem: String = ""
    @objc dynamic var topGradientColorHex: String = ""
    @objc dynamic var bottomGradientColorHex: String = ""

    override static func primaryKey() -> String? { return #keyPath(AlbumRealmModel.id) }

    func getModel() -> CardModel {
        let model = CardModel(id: self.id, cardNumber: self.cardNumber, expiryDate: self.expiryDate, cvvCode: self.cvvCode, cardHolder: self.cardHolder, type: self.type, bankName: self.bankName, paymentSystem: self.paymentSystem, topGradientColorHex: self.topGradientColorHex, bottomGradientColorHex: self.bottomGradientColorHex)
        return model
    }

    static func convert(from model: CardModel) -> CardRealmModel {
        let realmModel = CardRealmModel()
        realmModel.id = model.id
        realmModel.cardNumber = model.cardNumber
        realmModel.expiryDate = model.expiryDate
        realmModel.cvvCode = model.cvvCode
        realmModel.cardHolder = model.cardHolder
        realmModel.type = model.type
        realmModel.bankName = model.bankName
        realmModel.paymentSystem = model.paymentSystem
        realmModel.topGradientColorHex = model.topGradientColorHex
        realmModel.bottomGradientColorHex = model.bottomGradientColorHex

        return realmModel
    }

    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(CardRealmModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}
