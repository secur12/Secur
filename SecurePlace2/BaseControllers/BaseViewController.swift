//
//  BaseViewController.swift
//  Cherdak
//
//  Created by Emil Karimov on 13.09.2018.
//  Copyright © 2018 Emil Karimov. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNeedsStatusBarAppearanceUpdate()

    }

    func setTitleAndImage(title: String, imageName: String, tag: Int) {
        self.title = title
        let tabImage = UIImage(named: imageName)
        self.tabBarItem = UITabBarItem(title: title, image: tabImage, tag: tag)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func showAlert(title: String?, message: String?, buttons: [UIAlertAction]) {
        self.showAlertController(style: .alert) {
            $0.title = title
            $0.message = message
            for button in buttons {
                $0.addAction(button)
            }
        }
    }

    func showAlertController(style: UIAlertController.Style, setupBlock: (UIAlertController) -> Void) {

        let alertController: UIAlertController = UIAlertController(title: "Ошибка", message: nil, preferredStyle: style)
        setupBlock(alertController)

        if alertController.actions.count < 1 {
            fatalError("No actions provided in alert controller")
        }

        self.present(alertController, animated: true, completion: nil)
    }

    public func showLoading(message: String?) {
        if let message = message {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
        } else {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
        }
    }
    
    public func hideLoading() {
       MBProgressHUD.hideAllHUDs(for: view, animated: true)
    }
    
    public func showOkAlertController(title: String?, message: String?, callback: (() -> Void)? = nil) {
        self.showAlertController(style: .alert) {
            $0.title = title
            $0.message = message
            let action = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                if callback != nil {
                    callback!()
                }
            })
            $0.addAction(action)
        }
    }

    public func showNotYetRealizedAlert() {
        self.showAlertController(style: .alert) {
            $0.title = "This function is not realized"
            $0.message = "Соррри"
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            $0.addAction(action)
        }
    }

    @objc func popBack(from: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
