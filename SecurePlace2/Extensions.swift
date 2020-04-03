//
//  Extensions.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 08.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
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


