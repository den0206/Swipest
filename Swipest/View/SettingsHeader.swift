
//
//  SettingsHeader.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage

protocol SettingsHeaderDelegate : class {
    func selectingPhoto(_ header : SettingsHeaderView, didSelect index : Int)
}

class SettingsHeaderView : UIView {
    
    weak var delegate : SettingsHeaderDelegate?
    
    private let user : User
    //MARK: - Parts
    
    var buttons = [UIButton]()
    lazy var button1 = createButton(0)
    lazy var button2 = createButton(1)
    lazy var button3 = createButton(2)
    
    
    init(user : User) {
        self.user = user

        super.init(frame: .zero)
        
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
        
        loadUserPhots()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func loadUserPhots() {
        
        let imageUrls = user.profileImageUrl.map({URL(string: $0)})
        
        for(index, url) in imageUrls.enumerated() {
            SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                self.buttons[index].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        
    }
    
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
