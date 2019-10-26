//
//  BundleExtensions.swift
//  Wendy
//
//  Created by Levi Bostian on 3/30/18.
//

import Foundation

internal extension Bundle {

    internal class func bundleUrlForWendyFramework() -> Bundle {
        let frameworkBundle = Bundle(for: Wendy.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("Wendy.bundle")
        return Bundle.init(url: bundleURL!)!
    }

    internal class func frameworkUrlForWendyFramework() -> Bundle {
        let frameworkBundle = Bundle(for: Wendy.self)
        let bundleURL = frameworkBundle.resourceURL
        return Bundle.init(url: bundleURL!)!
    }

}
