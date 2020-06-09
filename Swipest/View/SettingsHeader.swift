
//
//  SettingsHeader.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SettingsHeaderView : UIView {
    
    //MARK: - Parts
    
    var buttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemRed
        
        let button1 = createButton()
        let button2 = createButton()
        let button3 = createButton()
        
        addSubview(button1)
        button1.anchor(top : topAnchor, left :leftAnchor,bottom: bottomAnchor,paddingTop: 16,paddingLeft: 16,paddingBottom: 16)
        
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [button2,button3])
        
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        addSubview(stack)

        stack.anchor(top : topAnchor,left:  button1.rightAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 16, paddingBottom: 16,paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func createButton() -> UIButton{
        
        let button = UIButton(type: .system)
        button.setTitle("Photo", for: .normal)
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }
    
    //MARK: - Actions
    
    @objc func selectPhoto() {
        
    }
}
