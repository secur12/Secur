//
//  BaseNavigationControllerPresenter.swift
//  Cherdak
//
//  Created by Emil Karimov on 14/09/2018.
//  Copyright © 2018 Emil Karimov. All rights reserved.
//

class BaseNavigationControllerPresenter: BasePresenter {

    weak var view: BaseNavigationControllerViewProtocol?
    private var wireFrame: BaseNavigationControllerWireFrameProtocol
    private var interactor: BaseNavigationControllerInteractorProtocol

    init(view: BaseNavigationControllerViewProtocol, wireFrame: BaseNavigationControllerWireFrameProtocol, interactor: BaseNavigationControllerInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension BaseNavigationControllerPresenter: BaseNavigationControllerPresenterProtocol { }
