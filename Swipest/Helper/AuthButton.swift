//
//  AuthButton.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class AuthButton : UIButton {
    
    init(title : String, type : ButtonType) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        isEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

func configTerxtField(placehiolder : String, isSecureMode : Bool? = false) -> UITextField {
    let tf = UITextField()
    
    let space = UIView()
    
    space.setDimensions(height: 50, width: 12)
    tf.leftView = space
    tf.leftViewMode = .always
    
    tf.borderStyle = .none
    tf.textColor = .white
    tf.keyboardAppearance = .dark
    tf.backgroundColor = UIColor(white: 1, alpha: 0.2)
    tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
    tf.layer.cornerRadius = 5
    tf.attributedPlaceholder = NSAttributedString(string: placehiolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 0.2)])
    tf.isSecureTextEntry = isSecureMode!
    
    return tf
    
}
