//
//  SSDeleteButton.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 10/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class SSDeleteButton: UIButton {

    private var minusView: UIView = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func createUI() {
        addSubview(minusView)
        
        layer.cornerRadius = 11.5.withRatio()
        backgroundColor = Colors.deleteRedColor
        snp.makeConstraints { (make) in
            make.height.width.equalTo(23.withRatio())
        }
        
        minusView.backgroundColor = UIColor.white
        minusView.snp.makeConstraints { (make) in
            make.height.equalTo(1.withRatio())
            make.width.equalTo(11.withRatio())
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
