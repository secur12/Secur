//
//  SSMasterPasswordSetupPresenter.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//
import KeychainAccess

class MasterPasswordSetupPresenter: BasePresenter {

    weak var view: MasterPasswordSetupViewProtocol?
    private var wireFrame: MasterPasswordSetupWireFrameProtocol
    private var interactor: MasterPasswordSetupInteractorProtocol
    private var type: MasterPasswordScreenType

    init(view: MasterPasswordSetupViewProtocol, wireFrame: MasterPasswordSetupWireFrameProtocol, interactor: MasterPasswordSetupInteractorProtocol, type: MasterPasswordScreenType) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
    }

    func didClickContinue(password: String) {
        if(password.count<7) {
            self.view?.passwordNotComplex()
        } else {
            if(type == .launchInput) {
                do {
                let keychain = Keychain(service: "com.secur.SecurInc")
                guard let encryptedPrivateKeyData = keychain[data: "privateKeyCrypted"] else { return }
                guard let privateKeySalt = keychain[data: "privateKeySalt"] else { return }
                guard let privateKeyIV = keychain[data: "privateKeyIV"] else { return }

                let key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: privateKeySalt)
                let aes = try AES256Crypter(key: key, iv: privateKeyIV)
                let decryptedPrivateKeyData = try aes.decrypt(encryptedPrivateKeyData)

                if(String(data: decryptedPrivateKeyData, encoding: String.Encoding.utf8) != nil) {
                    keychain[data: "privateKeyDecryptedData"] = decryptedPrivateKeyData
                    self.wireFrame.switchToTabBar(from: self.view)
                } else {
                    self.view?.showOkAlertController(title: "Error", message: "Master password is incorrect. Try again.", callback: nil)
                }

                } catch {
                    self.view?.showOkAlertController(title: "Error", message: "Error in decrypting process. Try to restart the app.", callback: nil)
                }
            } else if (type == .setupMasterPass) {
                self.wireFrame.switchToPrivateKey(from: self.view, password: password)
            }
        }
    }

    func viewDidLoad() {
        if(type == .launchInput) {
            self.view?.setupLaunchInputTexts()
        } else if (type == .setupMasterPass){
            self.view?.setupSetupMasterTexts()
        }
    }
}

extension MasterPasswordSetupPresenter: MasterPasswordSetupPresenterProtocol { }
