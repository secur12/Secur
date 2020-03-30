//
//  SSPlusButton.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/03/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class SSPlusButton: UIButton {

    init() {
        super.init(frame: CGRect.zero)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        setBackgroundImage(UIImage(named: "plusButton"), for: .normal)
    }

}
