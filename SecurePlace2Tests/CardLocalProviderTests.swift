//
//  CardLocalProviderTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 30/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import XCTest
@testable import SecurePlace2

class CardLocalProviderTests: XCTestCase {

    var sut: CardsLocalProvider!
    var testCardModel: CardModel!

    override func setUp() {
        sut = CardsLocalProvider(realmWrapper: RealmWrapper())
        testCardModel = CardModel(id: 0, cardNumber: "testCardNumber", expiryDate: "testExpiryDate", cvvCode: "testCVV", cardHolder: "testHolder", type: "Credit", bankName: "testBankName", paymentSystem: "testPaymentSystem", topGradientColorHex: "testTopColor", bottomGradientColorHex: "testBottomColor")
    }

    func testCardModelSaving () {
        sut.saveCard(testCardModel, completion: nil)
        sut.getCard(id: 0) { (cardModel, error) in
            if let error = error {
                XCTFail()
            }
            XCTAssertEqual(self.testCardModel, cardModel)
        }
    }

    func testCardDeleting () {
        sut.saveCard(testCardModel, completion: nil)
        sut.deleteCard(testCardModel, completion: nil)
        sut.getCard(id: 0) { (cardModel, error) in
            XCTAssertEqual(nil, cardModel)
        }
    }
}
