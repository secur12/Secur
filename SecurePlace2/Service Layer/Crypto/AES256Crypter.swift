//
//  CryptoService.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 18.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

protocol Randomizer {
    static func randomIv() -> Data
    static func randomSalt() -> Data
    static func randomData(length: Int) -> Data
}
protocol Crypter {
    func encrypt(_ digest: Data) throws -> Data
    func decrypt(_ encrypted: Data) throws -> Data
}
struct AES256Crypter {

    private var key: Data
    private var iv: Data

    public init(key: Data, iv: Data) throws {
        guard key.count == kCCKeySizeAES256 else {
            throw Error.badKeyLength
        }
        guard iv.count == kCCBlockSizeAES128 else {
            throw Error.badInputVectorLength
        }
        self.key = key
        self.iv = iv
    }

    enum Error: Swift.Error {
        case keyGeneration(status: Int)
        case cryptoFailed(status: CCCryptorStatus)
        case badKeyLength
        case badInputVectorLength
    }

    private func perormCryptingOperation(input: Data, operation: CCOperation) throws -> Data {
        var outLength = Int(0)
        var outBytes = [UInt8](repeating: 0, count: input.count + kCCBlockSizeAES128)
        var status: CCCryptorStatus = CCCryptorStatus(kCCSuccess)
        input.withUnsafeBytes { (encryptedBytes: UnsafePointer<UInt8>!) -> Void in
            iv.withUnsafeBytes { (ivBytes: UnsafePointer<UInt8>!) in
                key.withUnsafeBytes { (keyBytes: UnsafePointer<UInt8>!) -> Void in
                    status = CCCrypt(
                        operation,
                        //[1] Defines the basic operation: Encrypt or Decrypt
                        CCAlgorithm(kCCAlgorithmAES128),
                        //[2] Defines the algorithm (now - AES with 128 bits block length)
                        CCOptions(kCCOptionPKCS7Padding),
                        //[3] Defines the padding to use
                        keyBytes,
                        //[4] Key data
                        key.count,
                        //[5] Key length
                        ivBytes,
                        //[6] Initialize vector data
                        encryptedBytes,
                        //[7] Data to process (encrypt/decrypt) 
                        input.count,
                        //[8] Length of data to process
                        &outBytes,
                        //[9] Data output memory location. Result is written here
                        outBytes.count,
                        //[10] The size of the data output buffer in bytes
                        &outLength)
                        //[11] On successful return, the number of bytes written to data output
                }
            }
        }
        guard status == kCCSuccess else {
            throw Error.cryptoFailed(status: status)
        }
        return Data(bytes: UnsafePointer<UInt8>(outBytes), count: outLength)
    }

    static func createKey(password: Data, salt: Data) throws -> Data {
        let length = kCCKeySizeAES256 // key length 256 bits
        var status = Int32(0)
        var derivedBytes = [UInt8](repeating: 0, count: length)
        password.withUnsafeBytes { (passwordBytes: UnsafePointer<Int8>!) in
            salt.withUnsafeBytes { (saltBytes: UnsafePointer<UInt8>!) in
                status = CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    //[1] Defines key derivation algorithm (currently only PBKDF2 is available)
                    passwordBytes,
                    //[2] Text password
                    password.count,
                    //[3] The length of the text password in bytes
                    saltBytes,
                    //[4] Text salt
                    salt.count,
                    //[5] The length of the text salt in bytes
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1),
                    //[6] The Pseudo Random Algorithm to use for the derivation
                    10000,
                    //[7] Derivation rounds
                    &derivedBytes,
                    //[8] Final derived key memory location
                    length)
                    //[9] Derived output key length
            }
        }
        guard status == 0 else {
            throw Error.keyGeneration(status: Int(status))
        }
        return Data(bytes: UnsafePointer<UInt8>(derivedBytes), count: length)
    }

}

extension AES256Crypter: Crypter {

    func encrypt(_ decrypted: Data) throws -> Data {
        return try perormCryptingOperation(input: decrypted, operation: CCOperation(kCCEncrypt))
    }

    func decrypt(_ encrypted: Data) throws -> Data {
        return try perormCryptingOperation(input: encrypted, operation: CCOperation(kCCDecrypt))
    }

}

extension AES256Crypter: Randomizer {

    static func randomIv() -> Data {
        return randomData(length: kCCBlockSizeAES128)
    }

    static func randomSalt() -> Data {
        return randomData(length: 8)
    }

    static func randomData(length: Int) -> Data {
        var data = Data(count: length)
        let status = data.withUnsafeMutableBytes { mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, length, mutableBytes)
        }
        assert(status == Int32(0))
        return data
    }
}
