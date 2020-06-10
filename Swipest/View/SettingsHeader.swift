
//
//  SettingsHeader.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol SettingsHeaderDelegate : class {
    func selectingPhoto(_ header : SettingsHeaderView, didSelect index : Int)
}

class SettingsHeaderView : UIView {
    
    weak var delegate : SettingsHeaderDelegate?
    
    //MARK: - Parts
    
    var buttons = [UIButton]()
    lazy var button1 = createButton(0)
    lazy var button2 = createButton(1)
    lazy var button3 = createButton(2)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        buttons = [button1,button2,button3]
        
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
    
    func createButton(_ index : Int) -> UIButton{
        
        let button = UIButton(type: .system)
        button.setTitle("Photo", for: .normal)
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = index
        
        return button
    }
    
    //MARK: - Actions
    
    @objc func selectPhoto(sender : UIButton) {
        delegate?.selectingPhoto(self, didSelect: sender.tag)
    }
}
