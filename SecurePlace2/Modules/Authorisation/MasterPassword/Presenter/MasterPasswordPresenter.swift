//
//  SSMasterPasswordPresenter.swift
//  SecurePlace2
//
//  Created by YY on 29/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//
import Foundation

@objc enum MasterPasswordModuleType: Int {
    case signIn
    case installColdpass
    case PINChange
    case changeMasterPassword
}

class MasterPasswordPresenter: BasePresenter {

    weak var view: MasterPasswordViewProtocol?
    private var wireFrame: MasterPasswordWireFrameProtocol
    private var interactor: MasterPasswordInteractorProtocol

    private var accessToken: String?
    private var refreshToken: String?
    
    private var decryptKeySalt: String?
    private var decryptKeyIV: String?
    
    init(view: MasterPasswordViewProtocol, wireFrame: MasterPasswordWireFrameProtocol, interactor: MasterPasswordInteractorProtocol, type: MasterPasswordModuleType, accessToken: String?, refreshToken: String?, decryptKeySalt: String?, decryptKeyIV: String?) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.decryptKeySalt = decryptKeySalt
        self.decryptKeyIV = decryptKeyIV
    }
}

extension MasterPasswordPresenter: MasterPasswordPresenterProtocol { }
