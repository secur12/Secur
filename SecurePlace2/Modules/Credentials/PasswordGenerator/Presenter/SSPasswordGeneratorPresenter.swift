//
//  SSPasswordGeneratorPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class PasswordGeneratorPresenter: BasePresenter {

    weak var view: PasswordGeneratorViewProtocol?
    private var wireFrame: PasswordGeneratorWireFrameProtocol
    private var interactor: PasswordGeneratorInteractorProtocol

    init(view: PasswordGeneratorViewProtocol, wireFrame: PasswordGeneratorWireFrameProtocol, interactor: PasswordGeneratorInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension PasswordGeneratorPresenter: PasswordGeneratorPresenterProtocol { }
