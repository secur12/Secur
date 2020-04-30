//
//  SSAddCardPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class AddCardPresenter: BasePresenter {

    weak var view: AddCardViewProtocol?
    private var wireFrame: AddCardWireFrameProtocol
    private var interactor: AddCardInteractorProtocol

    init(view: AddCardViewProtocol, wireFrame: AddCardWireFrameProtocol, interactor: AddCardInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AddCardPresenter: AddCardPresenterProtocol { }
