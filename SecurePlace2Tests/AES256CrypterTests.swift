//
//  AES256CrypterTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 31/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import XCTest
import Foundation
@testable import SecurePlace2

class AES256CrypterTests: XCTestCase {

    var sut: AES256Crypter!
    var key: Data!
    var salt: Data!
    var iv: Data!
    var sourceData: Data!
    var password: String!

    override func setUp() {
        do {
            password = "testPassword"
            sourceData = "testData".data(using: .utf8)!
            iv = AES256Crypter.randomIv()
            salt = AES256Crypter.randomSalt()
            key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: salt)
            sut = try AES256Crypter(key: key, iv: iv)
        } catch {

        }
    }

    func testEncryptDecrypt() throws {
        let encryptedData = try sut.encrypt(sourceData)
        let decryptedData = try sut.decrypt(encryptedData)
        XCTAssertEqual(String(data: decryptedData, encoding: String.Encoding.utf8), String(data: sourceData, encoding: String.Encoding.utf8))
    }
}
