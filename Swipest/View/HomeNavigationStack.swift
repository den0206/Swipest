//
//  HomeNavigationStack.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol HomeNavigationStackViewDelegate : class{
    func presentSettingPage()
    func presentMessage()
}



class HomeNavigationStackView : UIStackView {
    
    weak var delegate : HomeNavigationStackViewDelegate?
    
    //MARK: - parts
    
    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        
        settingButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingButton,UIView(), tinderIcon,UIView(),messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleMessage), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleSetting() {
        delegate?.presentSettingPage()
    }
    
    @objc func handleMessage() {
        delegate?.presentMessage()
    }
}
