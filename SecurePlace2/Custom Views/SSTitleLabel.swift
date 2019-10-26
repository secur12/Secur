//
//  SSTitleLabel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 06.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit

class SSTitleLabel: UILabel {
    
        init(title: String) {
            super.init(frame: CGRect.zero)
            self.font = UIFont.systemFont(ofSize: 37.withRatio(), weight: .medium)
            self.text = title
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
