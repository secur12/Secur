//
//  SSMasterPasswordSetupPresenter.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//
import KeychainAccess
import LocalAuthentication

class MasterPasswordSetupPresenter: BasePresenter {

    weak var view: MasterPasswordSetupViewProtocol?
    private var wireFrame: MasterPasswordSetupWireFrameProtocol
    private var interactor: MasterPasswordSetupInteractorProtocol
    private var type: MasterPasswordScreenType
    private var oldMasterPassword: String

    init(view: MasterPasswordSetupViewProtocol, wireFrame: MasterPasswordSetupWireFrameProtocol, interactor: MasterPasswordSetupInteractorProtocol, type: MasterPasswordScreenType, oldMasterPassword: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.oldMasterPassword = oldMasterPassword
    }

    func processLaunchInput() {

    }

    func notifyUser(_ msg: String, err: String?) {
        self.view?.showOkAlertController(title: msg, message: err, callback: nil)
    }

    func didClickContinue(password: String) {
        if(password.count<7) {
            self.view?.passwordNotComplex()
        } else {
            if(type == .launchInput) {

            let defaults = UserDefaults.standard
            if(defaults.bool(forKey: "biometricsAuthEnabled") == true) {
                let context = LAContext()
                var error: NSError?

                if context.canEvaluatePolicy(
                    LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                    error: &error) {

                    context.evaluatePolicy(
                        LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                        localizedReason: "Access requires authentication",
                        reply: {(success, error) in
                            DispatchQueue.main.async {
                        if let err = error {
                            switch err._code {
                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                err: err.localizedDescription)
                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                err: err.localizedDescription)
                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                err: "Password option selected")
                            default:
                                self.notifyUser("Authentication failed",
                                err: err.localizedDescription)
                            }
                                } else {
                                    self.processInput(password: password)
                                }
                            }
                    })
                } else {
                    processInput(password: password)
                }
            } else {
                    processInput(password: password)
        }
            } else if (type == .setupMasterPass) {
                self.wireFrame.switchToPrivateKey(from: self.view, password: password)
            } else if (type == .changeTypeOldMasterPassword) {
                processCheckIfMasterPasswordIsCorrect(password: password)
            } else if (type == .changeTypeNewMasterPassword) {
                processSetupNewMasterPassword(newPassword: password)
            }
        }
    }

    func processSetupNewMasterPassword(newPassword: String) {
        do {
             let keychain = Keychain(service: "com.secur.SecurInc")

             guard let decryptedPrivateKeyData = keychain[data: "privateKeyDecryptedData"] else { return }
             guard let privateKeySalt = keychain[data: "privateKeySalt"] else { return }
             guard let privateKeyIV = keychain[data: "privateKeyIV"] else { return }
             let key = try AES256Crypter.createKey(password: newPassword.data(using: .utf8)!, salt: privateKeySalt)
             let aes = try AES256Crypter(key: key, iv: privateKeyIV)
             let encryptedPrivateKeyData = try aes.encrypt(decryptedPrivateKeyData)
             keychain[data: "privateKeyCrypted"] = encryptedPrivateKeyData

             self.wireFrame.switchToTabBar(from: self.view)

         } catch {
             self.view?.showOkAlertController(title: "Error", message: "Error in decrypting process. Try to restart the app.", callback: nil)
             self.wireFrame.switchToTabBar(from: self.view)

         }
    }

    func processCheckIfMasterPasswordIsCorrect(password: String) {

        do {
            let keychain = Keychain(service: "com.secur.SecurInc")
            guard let encryptedPrivateKeyData = keychain[data: "privateKeyCrypted"] else { return }
            guard let privateKeySalt = keychain[data: "privateKeySalt"] else { return }
            guard let privateKeyIV = keychain[data: "privateKeyIV"] else { return }

            let key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: privateKeySalt)
            let aes = try AES256Crypter(key: key, iv: privateKeyIV)
            let decryptedPrivateKeyData = try aes.decrypt(encryptedPrivateKeyData)

            if(String(data: decryptedPrivateKeyData, encoding: String.Encoding.utf8) != nil) {
                self.wireFrame.switchToTypeNewMasterPassword(from: self.view, oldMasterPassword: password)
            } else {
                self.view?.showOkAlertController(title: "Error", message: "Master password is incorrect. Try again.", callback: nil)
            }

        } catch {
            self.view?.showOkAlertController(title: "Error", message: "Error in decrypting process. Try to restart the app.", callback: nil)
        }
    }

    func processInput(password: String) {
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
                keychain[data: "realmKey"] = decryptedPrivateKeyData
                self.wireFrame.switchToTabBar(from: self.view)
            } else {
                self.view?.showOkAlertController(title: "Error", message: "Master password is incorrect. Try again.", callback: nil)
            }

        } catch {
            self.view?.showOkAlertController(title: "Error", message: "Error in decrypting process. Try to restart the app.", callback: nil)
        }
    }

    func viewDidLoad() {
        if(type == .launchInput) {
            self.view?.setupLaunchInputTexts()
        } else if (type == .setupMasterPass){
            self.view?.setupSetupMasterTexts()
        } else if (type == .changeTypeOldMasterPassword) {
            self.view?.setupChangeTypeOldMasterPassword()
        } else if (type == .changeTypeNewMasterPassword) {
            self.view?.setupChangeTypeNewMasterPassword()
        }
    }
}

extension MasterPasswordSetupPresenter: MasterPasswordSetupPresenterProtocol { }
