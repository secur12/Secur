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

    init(view: MasterPasswordViewProtocol, wireFrame: MasterPasswordWireFrameProtocol, interactor: MasterPasswordInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension MasterPasswordPresenter: MasterPasswordPresenterProtocol { }
