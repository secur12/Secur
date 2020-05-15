//
//  StartScreenPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class StartScreenPresenter: BasePresenter {

    weak var view: StartScreenViewProtocol?
    private var wireFrame: StartScreenWireFrameProtocol
    private var interactor: StartScreenInteractorProtocol

    init(view: StartScreenViewProtocol, wireFrame: StartScreenWireFrameProtocol, interactor: StartScreenInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension StartScreenPresenter: StartScreenPresenterProtocol {
    func switchToMaster() {
        self.wireFrame.presentMasterPassword(from: self.view)
    }
//    func switchToEmail(type: EmailModuleType) {
//        self.wireFrame.presentEmail(from: self.view, type: type)
//    }
}
