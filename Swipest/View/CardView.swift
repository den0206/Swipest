//
//  CardView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CardView : UIView {
    
    //MARK: - Parts
    
    private let gradientLayer = CAGradientLayer()
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "kelly2")
        return iv
    }()
    
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Yuuki", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy), NSAttributedString.Key.foregroundColor : UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: "  20", attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        
        label.attributedText = attributedText
        return label
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(profileImageView)
        profileImageView.fillSuperview()
        
        /// infolabelを見える様に為
        configureGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(left : leftAnchor, bottom: bottomAnchor, right: rightAnchor,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right : rightAnchor,paddingRight: 16)
        
        /// add gradientLayer
        
    }
    
    override func layoutSubviews() {
        /// get Self.Frame
        
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1,1]
        layer.addSublayer(gradientLayer)
        
    }
}
