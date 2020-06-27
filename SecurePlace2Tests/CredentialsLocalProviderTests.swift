//
//  CredentialsLocalProviderTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 30/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import XCTest
@testable import SecurePlace2

class CredentialsLocalProviderTests: XCTestCase {

    var sut: CredentialLocalProvider!
    var testCredentialModel: CredentialModel!

    override func setUp() {
        sut = CredentialLocalProvider(realmWrapper: RealmWrapper())
        testCredentialModel = CredentialModel(id: 0, serviceLogoImageTitle: "testImageLogoTitle", serviceTitleLabel: "testTitle", usernameLabel: "testUsername", password: "testPassword", pathUrl: "testPathUrl")
    }

    func testCredentialEdit() {
        let newCredentialToTest = CredentialModel(id: 0, serviceLogoImageTitle: "", serviceTitleLabel: "", usernameLabel: "", password: "", pathUrl: "")
        sut.saveCredential(testCredentialModel, completion: nil)
        sut.editCredential(newCredentialToTest) { (result) in
            if(result ?? true) {
                self.sut.getCredential(0) { (editedCredential, error) in
                    if let error = error {
                        XCTFail()
                    }
                    XCTAssertEqual(newCredentialToTest, editedCredential)
                }
            } else {
                XCTFail()
            }
        }
    }

    func testCredentialModelSaving () {
        sut.saveCredential(testCredentialModel, completion: nil)
        sut.getCredential(0) { (credentialModel, error) in
            if let error = error {
                XCTFail()
            }
            XCTAssertEqual(self.testCredentialModel, credentialModel)
        }
    }

    func testCredentialDeleting () {
        sut.saveCredential(testCredentialModel, completion: nil)
        sut.deleteCredential(testCredentialModel, completion: nil)
        sut.getCredential(0) { (mediaModel, error) in
            XCTAssertEqual(nil, mediaModel)
        }
    }
}
