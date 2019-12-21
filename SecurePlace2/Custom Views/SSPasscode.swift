//
//  SSPasscode.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/12/2019.
//  Copyright © 2019 Dwarvesf. All rights reserved.
//

import UIKit

class SSPasscode: UIView, UITextInputTraits {
    
    var keyboardType: UIKeyboardType = .numberPad
    var didFinishedEnterCode:((String)-> Void)?
    
    var code: String = "" {
        didSet {
            updateStack(by: code)
            if code.count == maxLength, let didFinishedEnterCode = didFinishedEnterCode {
                self.resignFirstResponder()
                didFinishedEnterCode(code)
            }
        }
    }
    var maxLength = 6
    
    //MARK: - UI
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        showKeyboardIfNeeded()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SSPasscode {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private func showKeyboardIfNeeded() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc private func showKeyboard() {
        self.becomeFirstResponder()
    }
}


extension SSPasscode: UIKeyInput {
    var hasText: Bool {
        return code.count > 0
    }
    func insertText(_ text: String) {
        if code.count == maxLength {
            return
        }
        code.append(contentsOf: text)
    }
    
    func deleteBackward() {
        if hasText {
            code.removeLast()
        }
    }
    
}

extension SSPasscode {
    
    private func setupUI() {
        addSubview(stack)
        self.backgroundColor = .white
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        updateStack(by: code)
    }
    
    private func emptyPin() -> UIView {
        let pin = Pin()
        pin.pin.backgroundColor = Colors.lightBlue
        return pin
    }
    
    private func pin() -> UIView {
        let pin = Pin()
        pin.pin.backgroundColor = Colors.brandBlue
        return pin
    }
    
    private func updateStack(by code: String) {
        var emptyPins:[UIView] = Array(0..<maxLength).map{_ in emptyPin()}
        let userPinLength = code.count
        let pins:[UIView] = Array(0..<userPinLength).map{_ in pin()}
        
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
        stack.removeAllArrangedSubviews()
        for view in emptyPins {
            stack.addArrangedSubview(view)
        }
    }
}


class Pin: UIView {

    let pin = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        pin.backgroundColor = .black
        pin.layer.cornerRadius = 7
        pin.layer.masksToBounds = true
        pin.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pin)
        NSLayoutConstraint.activate([
            pin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pin.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pin.widthAnchor.constraint(equalToConstant: 14.0),
            pin.heightAnchor.constraint(equalToConstant: 14.0),
            ])
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

