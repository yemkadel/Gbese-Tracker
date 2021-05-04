//
//  BaseTextField.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 10/04/2021.
//

import UIKit
class BaseTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    init(placeHolder: String?=nil){
        super.init(frame: CGRect.zero)
        
        returnKeyType = .next
        attributedPlaceholder = NSAttributedString(string: placeHolder ?? "", attributes: [.foregroundColor : UIColor.white])
       
        autocorrectionType = .no
        autocapitalizationType = .none
        enablesReturnKeyAutomatically = true
        
        tintColor = .white
        textColor = .white
    }
    
    //setting the size of the textField
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 45)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
