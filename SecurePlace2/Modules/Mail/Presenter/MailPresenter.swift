//
//  testPresenter.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

class MailPresenter: BasePresenter {

    weak var view: MailViewProtocol?
    private var wireFrame: MailWireFrameProtocol
    private var interactor: MailInteractorProtocol
    private var type: EmailConttrollerType

    init(view: MailViewProtocol, wireFrame: MailWireFrameProtocol, interactor: MailInteractorProtocol, type: EmailConttrollerType) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
    }
}

extension MailPresenter: MailPresenterProtocol { }
