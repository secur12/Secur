//
//  AppDelegate.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 08.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit
import Wendy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkProvider: NetworkRequestProvider! = nil
    let accountManager = AccountManager(environmet: .develop)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    
        Wendy.setup(tasksFactory: GroceryListPendingTasksFactory())
        #if DEBUG
        WendyConfig.debug = true
        #endif

        let networkWrapper = NetworkRequestWrapper()
        self.networkProvider = NetworkRequestProvider(networkWrapper: networkWrapper, tokenRefresher: nil, accountManager: self.accountManager)

        let resolver = DIResolver(networkController: self.networkProvider)
        let startScreenController = resolver.presentAlbumsViewController()
        let navi = UINavigationController(rootViewController: startScreenController)

        self.window?.rootViewController = navi //PINSetupViewController()
        self.window?.makeKeyAndVisible()
        
        do {
            let sourceData = "AES256".data(using: .utf8)!
            let password = "password"
            let salt = AES256Crypter.randomSalt()
            let iv = AES256Crypter.randomIv()
        
            let key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256Crypter(key: key, iv: iv)
            let encryptedData = try aes.encrypt(sourceData)
            
            let key2 = try AES256Crypter.createKey(password: "pass".data(using: .utf8)!, salt: salt)
            let aes2 = try AES256Crypter(key: key2, iv: iv)
            let decryptedData = try aes.decrypt(encryptedData)
            
            print("Decrypted hex string: \(String(data: decryptedData, encoding: String.Encoding.utf8))")
            print("Encrypted hex string: \(encryptedData.base64EncodedData())")
        } catch {
            print("Failed")
            print(error)
        }

        //IQKeyboardManager.shared().isEnabled = true
        
        print("App did LAunched")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
