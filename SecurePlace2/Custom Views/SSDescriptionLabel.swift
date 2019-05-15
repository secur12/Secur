//
//  SSDescriptionLabel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 07.05.2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit

class SSDescriptionLabel: UILabel {

    init(text: String, containsBoldText: String, numberOfLines: Int) {
        super.init(frame: CGRect.zero)
        
        self.attributedText = SSDescriptionLabel.attributedTextWithBoldSubtext(withString: text, boldString: containsBoldText, font: UIFont.systemFont(ofSize: 18.withRatio(), weight: .light))
        self.textAlignment = .center
        self.numberOfLines = numberOfLines
    
    }
    
    init(text: String, containsItalicText: String, numberOfLines: Int) {
        super.init(frame: CGRect.zero)
        self.attributedText = SSDescriptionLabel.attributedTextWithItalicSubtext(withString: text, italicString: containsItalicText, font: UIFont.systemFont(ofSize: 18.withRatio(), weight: .light))
        self.textAlignment = .center
        self.numberOfLines = numberOfLines
        
    }
    
    init(text: String, numberOfLines: Int) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 18.withRatio(), weight: .light)
        self.textAlignment = .center
        self.numberOfLines = numberOfLines
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SSDescriptionLabel {
    
    static func attributedTextWithBoldSubtext(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    static func attributedTextWithItalicSubtext(withString string: String, italicString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let italicFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: italicString)
        attributedString.addAttributes(italicFontAttribute, range: range)
        return attributedString
    }
    
}
