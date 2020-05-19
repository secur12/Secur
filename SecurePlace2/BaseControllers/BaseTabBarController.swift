//
//  BaseTabBarController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 09/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//
import UIKit

class BaseTabBarController: UITabBarController {

    private var resolver: DIResolver! = nil

    init(resolver: DIResolver) {
        self.resolver = resolver

        super.init(nibName: nil, bundle: nil)
        self.viewControllers = self.getControllers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        self.createUI()
    }
}

// MARK: - Privates
extension BaseTabBarController {

    private func createUI() {
        self.view.backgroundColor = UIColor.white
        self.tabBar.tintColor = Colors.brandBlue
    }

    private func getControllers() -> [UIViewController] {

        let selectedColor = UIColor.RGB(r: 62, g: 81, b: 97)

        let albumsController = UINavigationController(rootViewController: self.resolver.presentAlbumsViewController())
        let albumsButton = UITabBarItem.init(title: "Albums", image: UIImage(systemName: "rectangle.stack"), selectedImage: UIImage(systemName: "rectangle.stack.fill"))
        albumsButton.tag = 1
        albumsController.tabBarItem = albumsButton

        let cardsController = UINavigationController(rootViewController: resolver.presentCardsViewController())
        let cardsButton = UITabBarItem.init(title: "Cards", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        cardsButton.tag = 2
        cardsController.tabBarItem = cardsButton

        let credentialsController = UINavigationController(rootViewController: resolver.presentCredentialsViewController())
        let credentialsButton = UITabBarItem(title: "Credentials", image: UIImage(systemName: "person.icloud"), selectedImage: UIImage(systemName: "person.icloud.fill"))
        credentialsButton.tag = 3
        credentialsController.tabBarItem = credentialsButton
        
        let settingsController = UINavigationController(rootViewController: resolver.presentPreferencesViewController())
        let settingsButton = UITabBarItem.init(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        settingsButton.tag = 4
        settingsController.tabBarItem = settingsButton
        
        
        return [albumsController, cardsController, credentialsController, settingsController]
    }
}

