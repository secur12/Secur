//
//  Extensions.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 08.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    func withRatio() -> CGFloat {
        return self * (UIScreen.main.bounds.width / 375)
    }
    
}

extension Double {
    
    func withRatio() -> CGFloat {
        return CGFloat(self) * (UIScreen.main.bounds.width / 375)
    }
    
}

extension Int {
    
    func withRatio() -> CGFloat {
        return CGFloat(self) * (UIScreen.main.bounds.width / 375)
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

