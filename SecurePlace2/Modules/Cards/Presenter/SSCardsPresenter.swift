//
//  SSCardsPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class CardsPresenter: BasePresenter {

    weak var view: CardsViewProtocol?
    private var wireFrame: CardsWireFrameProtocol
    private var interactor: CardsInteractorProtocol

    init(view: CardsViewProtocol, wireFrame: CardsWireFrameProtocol, interactor: CardsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension CardsPresenter: CardsPresenterProtocol { }
