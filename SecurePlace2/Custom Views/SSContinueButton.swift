//
//  SSContinueButton.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 07.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit

class SSContinueButton: UIButton {

    init(title: String) {
        super.init(frame: CGRect.zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(Colors.textBlue, for: .normal)
        self.setTitleColor(Colors.buttonBlue, for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
