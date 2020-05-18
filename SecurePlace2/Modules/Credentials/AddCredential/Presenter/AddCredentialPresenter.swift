//
//  SSAddCredentialPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//
import Foundation

class AddCredentialPresenter: BasePresenter {

    weak var view: AddCredentialViewProtocol?
    private var wireFrame: AddCredentialWireFrameProtocol
    private var interactor: AddCredentialInteractorProtocol
    private var provider = CredentialLocalProvider(realmWrapper: RealmWrapper())

    init(view: AddCredentialViewProtocol, wireFrame: AddCredentialWireFrameProtocol, interactor: AddCredentialInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AddCredentialPresenter: AddCredentialPresenterProtocol {

    func didClickEditButton(id: Int, name: String, serviceLogoTitle: String, service: String, username: String, password: String, urlPath: String) {
        let credentialModel = CredentialModel(id: id, serviceLogoImageTitle: serviceLogoTitle, serviceTitleLabel: name, usernameLabel: username, password: password, pathUrl: urlPath)
        provider.editCredential(credentialModel) { (isOk) in
            if isOk == true {
                DispatchQueue.main.async {
                    self.view?.popViewController()
                }
            } else {
               self.view?.showOkAlertController(title: "Error", message: "Error during card save", callback: nil)
            }
        }
    }

    func didClickActionButton(name: String, serviceLogoTitle: String, service: String, username: String, password: String, urlPath: String) {
        let credentialModel = CredentialModel(id: 0, serviceLogoImageTitle: serviceLogoTitle, serviceTitleLabel: name, usernameLabel: username, password: password, pathUrl: urlPath)

            provider.saveCredential(credentialModel) { (credentialModel) in
                if let credentialModel = credentialModel {
                    DispatchQueue.main.async {
                        self.view?.popViewController()
                    }
                } else {
                    self.view?.showOkAlertController(title: "Error", message: "Error during card save", callback: nil)
                }
        }
    }
}
