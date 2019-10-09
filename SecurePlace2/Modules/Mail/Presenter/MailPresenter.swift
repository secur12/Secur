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
    private var type: EmailModuleType

    init(view: MailViewProtocol, wireFrame: MailWireFrameProtocol, interactor: MailInteractorProtocol, type: EmailModuleType) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
    }
    
    func getModuleType() -> EmailModuleType {
        return self.type
    }
    
}

extension MailPresenter: MailPresenterProtocol {
    func resetPIN(with email: String) {
        print("Reset PIN code")
    }
    
    
    func signUpUser(with email: String) {
        print("Sign Up")
    }
    
    func signInUser(with email: String) {
        print("Sign In")
    }
}
