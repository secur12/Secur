//
//  SSPrivateKeyPresenter.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//
import KeychainAccess

class PrivateKeyPresenter: BasePresenter {

    weak var view: PrivateKeyViewProtocol?
    private var wireFrame: PrivateKeyWireFrameProtocol
    private var interactor: PrivateKeyInteractorProtocol
    private var masterPassword: String

    init(view: PrivateKeyViewProtocol, wireFrame: PrivateKeyWireFrameProtocol, interactor: PrivateKeyInteractorProtocol, password: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.masterPassword = password
    }
}

extension PrivateKeyPresenter: PrivateKeyPresenterProtocol {
    func didClickContinue(privateKey: String) {

        let keychain = Keychain(service: "com.secur.SecurInc")

        let privateKeySHA1 = privateKey.sha1()
        keychain["privateKeySHA1"] = privateKeySHA1

        do {
            var privateKeyDecryptedData = privateKey.data(using: .utf8)!

            let additionalBytesLength = 64-privateKeyDecryptedData.count
            privateKeyDecryptedData.append(Data(count: additionalBytesLength))

            let privateKeySalt = AES256Crypter.randomSalt()
            let privateKeyIV = AES256Crypter.randomIv()
            let key = try AES256Crypter.createKey(password: masterPassword.data(using: .utf8)!, salt: privateKeySalt)
            let aes = try AES256Crypter(key: key, iv: privateKeyIV)
            let encryptedPrivateKeyData = try aes.encrypt(privateKeyDecryptedData)

//            var realmK = Data(count: 64)
//            _ = realmK.withUnsafeMutableBytes { bytes in
//              SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
//            }
            keychain[data: "realmKey"] = privateKeyDecryptedData

            keychain[data: "privateKeyCrypted"] = encryptedPrivateKeyData
            keychain[data: "privateKeySalt"] = privateKeySalt
            keychain[data: "privateKeyIV"] = privateKeyIV

            keychain[data: "privateKeyDecryptedData"] = privateKeyDecryptedData
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "appSetupProcessFinished")

            self.wireFrame.switchToTabBar(from: self.view)
        } catch {
            self.view?.showOkAlertController(title: "Error", message: "Something went wrong, try again", callback: nil)
        }
        //get sha from priVateKEy and write it to Keychain privateKeySHA1
        //generate salt, iv for private key
        //encrypt privateKey with MasterPassword + salt + iv
        //write to Keychain privateKeyCrypted+ privateKeySalt + privateKeyIV
        //write to Keychain decryptedPrivateKey

        //APP CLOSE: delete decryptedPrivateKey from Keychain

        //APP OPEN: if privateKeyCrypted not null = open TYPE MASTER password
        //else OPEN StartScreen
    }
}
