//
//  CardModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 01/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

public struct CardModel: Codable {

    let id: Int
    let cardNumber: String
    let expiryDate: String
    let cvvCode: String
    let cardHolder: String
    let type: String
    let bankName: String
    let paymentSystem: String
    let topGradientColorHex: String
    let bottomGradientColorHex: String

    init(id: Int, cardNumber: String, expiryDate: String, cvvCode: String, cardHolder: String, type: String, bankName: String, paymentSystem: String, topGradientColorHex: String, bottomGradientColorHex: String) {
        self.id = id
        self.cardNumber = cardNumber
        self.expiryDate = expiryDate
        self.cvvCode = cvvCode
        self.cardHolder = cardHolder
        self.type = type
        self.bankName = bankName
        self.paymentSystem = paymentSystem
        self.topGradientColorHex = topGradientColorHex
        self.bottomGradientColorHex = bottomGradientColorHex
    }

    static func convertToData(card:CardModel) -> Data {
        var cardObject = card
        return Data(bytes: &cardObject, count: MemoryLayout<CardModel>.stride)
    }

    static func convertToCard(data:Data) -> CardModel {
        guard data.count == MemoryLayout<CardModel>.stride else {
            fatalError("")
        }

        var card:CardModel?
        data.withUnsafeBytes({(bytes: UnsafePointer<CardModel>)->Void in
            card = UnsafePointer<CardModel>(bytes).pointee
        })
        return card!
    }
}
