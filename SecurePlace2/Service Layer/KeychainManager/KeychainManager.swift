//
//  KeychainManager.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 24/12/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import CryptoKit
import KeychainAccess

class KeychainManager {
    
// MARK: - PIN Code
    //High level
    static func getHashedPIN(pin: String) -> String {
        let salt: String = UUID().uuidString
        let inputString: String = pin+salt
        let inputData: Data = Data(inputString.utf8)
        let hashedPINWithSalt: String = SHA256.hash(data: inputData).description
        
        return hashedPINWithSalt
    }
    
    static func isPINValid(pin: String) -> Bool {
        return false
    }
    
    //Low level
    private static func getPINHash() -> String {
        return ""
    }
    
    private static func setPINHash(hash: String) {
        
        let keychain = Keychain(service: "com.hilton.SecurePlace2")
        
        do {
            try keychain.set(hash, key: "pinHash")
        }
        catch let error {
            print(error)
        }
    }
    
    //Tokens
    
}
