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
    
    static var lightBlue: UIColor {
        return UIColor.RGB(r: 168, g: 216, b: 255)
    }
    
    static var lightGrey: UIColor {
        return UIColor.RGB(r: 137, g: 137, b: 137)
    }

    static var textLightGrey: UIColor {
        return UIColor.RGB(r: 211, g: 221, b: 229)
    }

    static var generateAlbumBackgroundColor: UIColor {
        return UIColor.RGB(r: 53, g: 89, b: 150)
    }
    
    static var plusButtonBorderBlue: UIColor {
        return UIColor.RGB(r: 56, g: 148, b: 247)
    }

    static var lightBlurBackground: UIColor {
         return UIColor.RGB(r: 239, g: 239, b: 244)
    }
    
    static var deleteRedColor: UIColor {
        return UIColor.RGB(r: 255, g: 59, b: 48)
    }

    //gradients
    static var blueGradient: [CGColor]  {
        return [UIColor.RGB(r: 168, g: 216, b: 255).cgColor, UIColor.RGB(r: 0, g: 123, b: 255).cgColor]
    }

    static var darkBlueGradient: [CGColor]  {
        return [UIColor.RGB(r: 56, g: 114, b: 255).cgColor, UIColor.RGB(r: 33, g: 29, b: 126).cgColor]
    }

    static var lightOrangeGradient: [CGColor]  {
        return [UIColor.RGB(r: 255, g: 212, b: 116).cgColor, UIColor.RGB(r: 255, g: 171, b: 64).cgColor]
    }

    static var redGradient: [CGColor]  {
        return [UIColor.RGB(r: 189, g: 48, b: 76).cgColor, UIColor.RGB(r: 121, g: 47, b: 50).cgColor]
    }

    static var darkOrangeGradient: [CGColor]  {
        return [UIColor.RGB(r: 253, g: 106, b: 59).cgColor, UIColor.RGB(r: 232, g: 36, b: 36).cgColor]
    }

    static var oceanGreenGradient: [CGColor]  {
        return [UIColor.RGB(r: 0, g: 153, b: 255).cgColor, UIColor.RGB(r: 0, g: 255, b: 206).cgColor]
    }

    static var redBlueGradient: [CGColor]  {
        return [UIColor.RGB(r: 101, g: 101, b: 255).cgColor, UIColor.RGB(r: 240, g: 36, b: 68).cgColor]
    }

    //get random gradient
    static func getRandomGradient() -> [CGColor] {
        let gradients = [blueGradient,
                darkBlueGradient,
                redGradient,
                darkOrangeGradient,
                redBlueGradient]
        return gradients.randomElement() ?? oceanGreenGradient
    }
}

extension UIColor {
    static func RGB(r: (Int), g: (Int), b: (Int), a: (CGFloat) = 1) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}

