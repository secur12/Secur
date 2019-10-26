//
//  FormControllerFork.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 08/10/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//


import UIKit

class BaseScrollViewController: BaseViewController {
    
    var lowestElement: UIView!
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        if #available(iOS 11.0, *) {
            sv.contentInsetAdjustmentBehavior = .never
        }
        sv.contentSize = view.frame.size
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    public let formContainerStackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        return sv
    }()
    
    public var alignment: FormAlignment
    
    public init(alignment: FormAlignment = .center) {
        self.alignment = alignment
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("You most likely have a Storyboard controller that uses this class, please remove any instance of LBTAFormController or sublasses of this component from your Storyboard files.")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)
        
        if alignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        setupKeyboardNotifications()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if formContainerStackView.frame.height > view.frame.height {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        }
        
        _ = distanceToBottom
    }
    
    lazy fileprivate var distanceToBottom = self.distanceFromLowestElementToBottom()
    
    fileprivate func distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.height - frame.origin.y
            return distance
        }
        
        return view.frame.height - formContainerStackView.frame.maxY
    }
    
    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height-30.withRatio()
        // when stackView is center aligned, we need some etra bottom padding, not sure why yet...
        if alignment == .center {
            scrollView.contentInset.bottom += UIApplication.shared.statusBarFrame.height
            scrollView.contentOffset.y = keyboardFrame.height-30.withRatio()
        }
        
        if distanceToBottom > 0 {
            scrollView.contentInset.bottom -= distanceToBottom
        }
        
        self.scrollView.scrollIndicatorInsets.bottom = keyboardFrame.height-30.withRatio()
        
    }
    
    @objc fileprivate func handleKeyboardHide() {
        self.scrollView.contentInset.bottom = 0
        self.scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    public enum FormAlignment {
        case top, center
    }
    
    func viewsAndIntsToStack(viewsAndSpacings: [Any]) {
        
        formContainerStackView.axis = .vertical
        formContainerStackView.distribution = .equalSpacing
        formContainerStackView.alignment = .center
        formContainerStackView.spacing = 0;
        
        for element in 0..<viewsAndSpacings.count {
            if let spacing = viewsAndSpacings[element] as? Int {
                let spacingView = UIView()
                spacingView.alpha = 0
                spacingView.snp.makeConstraints { (make) in
                    make.height.equalTo(spacing)
                }
                formContainerStackView.addArrangedSubview(spacingView)
                
                if(element == viewsAndSpacings.count-1) {
                    //self.lowestElement = spacingView
                    return
                }
            }
            
            if let view = viewsAndSpacings[element] as? UIView {
                formContainerStackView.addArrangedSubview(view)
                if(element == viewsAndSpacings.count-1) {
                    //self.lowestElement = view
                    return
                }
                
            }
        }
    }
    
}



