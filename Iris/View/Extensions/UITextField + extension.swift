//
//  UITextField + extension.swift
//  Zi Elengaz
//
//  Created by mahmoudhajar on 4/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit

private var KeyMaxLength: Int = 0


extension UITextField {
    
    
     func setRoundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
         self.clipsToBounds = true
    }
    
    /// MARK : - Change placeholder color
    
    @IBInspectable var placeHolderClor: UIColor? {
        get {
            return self.placeHolderClor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    /// MARK :- SET Padding space
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    /// Mark: - Restrict The Number Of Characters To Type In UITextFields

    
//    @IBInspectable var maxLength: Int {
//        get {
//            if let length = objc_getAssociatedObject(self, &KeyMaxLength) as? Int {
//                return length
//            } else {
//                return Int.max
//            }
//        }
//        set {
//            objc_setAssociatedObject(self, &KeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
//            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
//        }
//    }
//    
//    @objc func checkMaxLength(textField: UITextField) {
//        guard let prospectiveText = self.text,
//            prospectiveText.count > maxLength
//            else {
//                return
//        }
//        
//        let selection = selectedTextRange
//        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//        text = prospectiveText.substring(to: maxCharIndex)
//        selectedTextRange = selection
//    }
//    
    
    
}
