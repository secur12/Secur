//
//  Extensions.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 08.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

let deviceType = UIDevice.current.userInterfaceIdiom

extension CGFloat {
    
    func withRatio() -> CGFloat {
        switch deviceType {
         case .phone:
             return self * (UIScreen.main.bounds.width / 375)
         case .pad:
             return self
         case .unspecified:
             return CGFloat(self)
        case .tv:
            return CGFloat(self)
        case .carPlay:
            return CGFloat(self)
        }
    }
    
}

extension Double {
    
    func withRatio() -> CGFloat {
        switch deviceType {
         case .phone:
            return CGFloat(self) * (UIScreen.main.bounds.width / 375)
         case .pad:
             return CGFloat(self)
         case .unspecified:
             return CGFloat(self)
        case .tv:
            return CGFloat(self)
        case .carPlay:
            return CGFloat(self)
        }
    }
    
}

extension Int {
    
    func withRatio() -> CGFloat {
        switch deviceType {
         case .phone:
            return CGFloat(self) * (UIScreen.main.bounds.width / 375)
         case .pad:
             return CGFloat(self)
         case .unspecified:
             return CGFloat(self)
        case .tv:
            return CGFloat(self)
        case .carPlay:
            return CGFloat(self)
        }
    }
    
}

extension UIStackView {
    static func viewsAndIntsToStack(viewsAndSpacings: [Any]) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0;
        
        for element in viewsAndSpacings {
            if let spacing = element as? Int {
                let spacingView = UIView()
                spacingView.alpha = 0
                spacingView.snp.makeConstraints { (make) in
                    make.height.equalTo(spacing)
                }
                stackView.addArrangedSubview(spacingView)
            }
            
            if let view = element as? UIView {
                stackView.addArrangedSubview(view)
            }
        }
        return stackView
        
    }
    
    static func viewsAndIntsToStack(stackView: UIStackView, viewsAndSpacings: [Any]) {
    
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0;
        
        for element in viewsAndSpacings {
            if let spacing = element as? Int {
                let spacingView = UIView()
                spacingView.alpha = 0
                spacingView.snp.makeConstraints { (make) in
                    make.height.equalTo(spacing)
                }
                stackView.addArrangedSubview(spacingView)
            }
            
            if let view = element as? UIView {
                stackView.addArrangedSubview(view)
            }
        }
        
    }
}

extension String {
    static func validateEmail(strEmail: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format: "SELF MATCHES [c]%@", emailRegex)
        return (emailText.evaluate(with: strEmail))
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension UIDevice {
//    static func getDeviceRatio<T>(t: T) -> CGFloat {
//        switch deviceType {
//           case .phone:
//               return CGFloat(t * (UIScreen.main.bounds.width / 375))
//           case .pad:
//               return CGFloat(self)
//           case .unspecified:
//                return CGFloat(self)
//          case .tv:
//              return CGFloat(self)
//          case .carPlay:
//              return CGFloat(self)
//          }
//
//    }
}

extension UICollectionView {
    
    func getAllCells() -> [UICollectionViewCell] {
    var cells = [UICollectionViewCell]()
    // assuming tableView is your self.tableView defined somewhere
    for i in 0...self.numberOfSections-1
    {
        for j in 0...self.numberOfItems(inSection: i) - 1
        {
            if let cell = self.cellForItem(at: NSIndexPath(row: j, section: i) as IndexPath) {

                cells.append(cell)
            }
        }
    }
    return cells
    }
}

extension UICollectionView {
    
    func reloadWithoutScrolling() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1)
    }

    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }
}

extension String {
    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension Collection {
    var pairs: [SubSequence] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/2 + count % 2
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex]
        }
    }
}

extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.dropFirst().reversed()
            where distance(to: index).isMultiple(of: n) {
            insert(contentsOf: separator, at: index)
        }
    }
    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}

extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}


