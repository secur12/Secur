//
//  Colors.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 09.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    static var gradientLightBlue: UIColor {
        return UIColor.RGB(r: 0, g: 178, b: 255)
    }

    static var brandBlue: UIColor {
        return UIColor.RGB(r: 0, g: 123, b: 255)
    }

    static var textWhite: UIColor {
        return UIColor.RGB(r: 255, g: 255, b: 255)
    }

    static var darkBlue: UIColor {
        return UIColor.RGB(r: 22, g: 96, b: 178)
    }

    static var fieldGrey: UIColor {
        return UIColor.RGB(r: 142, g: 142, b: 147, a: 0.12)
    }

    static var textGrey: UIColor {
        return UIColor.RGB(r: 142, g: 142, b: 147)
    }

    static var textBlue: UIColor {
        return UIColor.RGB(r: 0, g: 122, b: 255)
    }

    static var buttonBlue: UIColor {
        return UIColor.RGB(r: 212, g: 233, b: 252)
    }
}

extension UIColor {
    static func RGB(r: (Int), g: (Int), b: (Int), a: (CGFloat) = 1) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}
