//
//  SSOneTimeCodePresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class OneTimeCodePresenter: BasePresenter {

    weak var view: OneTimeCodeViewProtocol?
    private var wireFrame: OneTimeCodeWireFrameProtocol
    private var interactor: OneTimeCodeInteractorProtocol

    init(view: OneTimeCodeViewProtocol, wireFrame: OneTimeCodeWireFrameProtocol, interactor: OneTimeCodeInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension OneTimeCodePresenter: OneTimeCodePresenterProtocol { }
