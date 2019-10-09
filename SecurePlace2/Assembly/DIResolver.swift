//
//  DIResolver.swift
//  Cherdak
//
//  Created by Emil Karimov on 11.09.2018.
//  Copyright © 2018 Emil Karimov. All rights reserved.
//

import UIKit

// MARK: - DIResolver
class DIResolver {

    let networkController: NetworkRequestProvider

    // MARK: - Init
    init(networkController: NetworkRequestProvider) {
        self.networkController = networkController
    }

}
