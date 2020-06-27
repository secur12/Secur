//
//  KeychainTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 31/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import XCTest
import KeychainAccess
@testable import SecurePlace2

class KeychainTests: XCTestCase {

    var sut: Keychain!
    var key: String!
    var value: String!

    override func setUp() {
        sut = Keychain(accessGroup: "com.secur.SecurInc")
        key = "testKey"
        value = "testValue"
    }

    func testKeychainReadWriteExample() {
        do {
            try sut.set(value, key: key)
            let valueFromKey = try sut.getString(key)
            XCTAssertEqual(valueFromKey, value)
        } catch {
        } 
    }
}
