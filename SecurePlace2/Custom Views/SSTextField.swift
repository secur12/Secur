//
//  SSTextField.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 10.04.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit

class SSTextField: UITextField {

    init(placeholder: String, type: UIKeyboardType) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = Colors.fieldGrey
        self.textColor = Colors.textGrey
        self.font = UIFont.systemFont(ofSize: 18.withRatio(), weight: .regular)
        self.layer.cornerRadius = 8.withRatio()
        self.placeholder = placeholder
        self.keyboardType = type
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let padding = UIEdgeInsets(top: 0, left: 15.withRatio(), bottom: 0, right: 5.withRatio())
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
