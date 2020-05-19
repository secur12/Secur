//
//  SSEnableBiometricAuthPresenter.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class EnableBiometricAuthPresenter: BasePresenter {

    weak var view: EnableBiometricAuthViewProtocol?
    private var wireFrame: EnableBiometricAuthWireFrameProtocol
    private var interactor: EnableBiometricAuthInteractorProtocol

    init(view: EnableBiometricAuthViewProtocol, wireFrame: EnableBiometricAuthWireFrameProtocol, interactor: EnableBiometricAuthInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension EnableBiometricAuthPresenter: EnableBiometricAuthPresenterProtocol { }
