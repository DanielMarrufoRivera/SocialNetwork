//
//  LocalizedErrorTextField.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 12/02/22.
//


import UIKit
import Material

class LocalizedErrorTextField: ErrorTextField {
    @IBInspectable
    open var showFloatingLabel: Bool {
        get {
            return self.placeholderActiveColor == .clear
        }
        set(value) {
            if !value{
                self.placeholderActiveColor = .clear
            }
        }
    }
    
    
    var hasButtonSelector = false
    var buttonDisabled = false
    var isLargeText = false
    var isActivated = false
    
    
    
    override var isEnabled:Bool {
        willSet {
            super.isEnabled = newValue
            
            if hasButtonSelector{
                self.placeholderNormalColor = Colors.primary.darken3
                
                if !newValue && buttonDisabled{
                    self.isDividerHidden = true
                }
            }else{
                if !newValue{
                    self.isDividerHidden = true
                }
            }
            
            //            if !alwaysShowPlaceholderColor && !newValue && self.text == ""{
            //                self.placeholderNormalColor = .lightGray
            //            }else{
            //                self.placeholderNormalColor = Colors.primary.darken3
            //            }
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        willSet {
            super.isUserInteractionEnabled = newValue
            
            isEnabled = isUserInteractionEnabled
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.placeholderLabel.text = (self.placeholderLabel.text ?? "")
        self.detailLabel.text = (self.detailLabel.text ?? "")
        
        self.placeholderVerticalOffset = 8
        self.detailVerticalOffset = -2
        
        self.detailColor = #colorLiteral(red: 0.8792808219, green: 0, blue: 0.02410620955, alpha: 1)
        
        self.placeholderNormalColor = Colors.primary.darken3
        self.placeholderActiveColor = Colors.primary.darken3
        
        
        self.placeholderActiveScale = 1.2
        if isSecureTextEntry{
            self.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        }
        //        else{
        self.font = UIFont(name: AppFontName.regular, size: 14)
        //        }
        
        //        self.placeholderLabel.shadowColor = .clear
        //        self.isDividerHidden = !self.isEnabled
        if hasButtonSelector{
            self.placeholderNormalColor = Colors.primary.darken3
            if !isEnabled && buttonDisabled{
                self.isDividerHidden = true
            }
        }else{
            if !isEnabled{
                self.isDividerHidden = true
            }
        }
        
    }
    
    
    /// Hide or show error text.
    override var isErrorRevealed: Bool {
        
        get {
            return errorLabel.isHidden
        }
        set {
            errorLabel.isHidden = newValue
            detailLabel.isHidden = !newValue
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        if !isActivated{
            if self.isLargeText{
                self.placeholderLabel.font = UIFont(name: AppFontName.medium, size: 8)
            }else{
                self.placeholderLabel.font = UIFont(name: AppFontName.medium, size: 14)
            }
        }else{
            if self.isLargeText{
                self.placeholderLabel.font = UIFont(name: AppFontName.medium, size: 8)
            }else{
                self.placeholderLabel.font = UIFont(name: AppFontName.medium, size: 10)
            }
        }
    }
}
