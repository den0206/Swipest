//
//  SettingFooter.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol SettingFooterViewDelegate : class {
    func handleLogout()
}

class SettingFooterView: UIView {
    
    weak var delegate : SettingFooterViewDelegate?
    
    //MARK: - Parts
    
    private lazy var logOutButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        
        addSubview(spacer)
        spacer.setDimensions(height: 32, width: frame.width)
        
        addSubview(logOutButton)
        logOutButton.anchor(top : spacer.bottomAnchor,left: leftAnchor,right: rightAnchor,height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func logOut() {
        delegate?.handleLogout()
    }
}
