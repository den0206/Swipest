//
//  CardView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum swipeDirection : Int {
    case left = -1
    case rigt = 1
}

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
    

    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender : UIPanGestureRecognizer) {
        
        
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            /// move card
            panCard(sender: sender)
            
        case .ended:
            
            resetCardPosition(sender: sender)
            
        default:
            break
        }
        
    }
    
    @objc func handleChangePhoto(sender : UITapGestureRecognizer) {
        print("Tap")
        
        
    }
    
    //MARK: - Helpers
    
    private func configureGradientLayer() {
        /// add gesture
        configGestureRecoganaizer()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1,1]
        layer.addSublayer(gradientLayer)
        
    }
    
    private func configGestureRecoganaizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
        
    }
    
    private func panCard(sender : UIPanGestureRecognizer) {
        
        /// move Cards
        let transration = sender.translation(in: nil)

        let degrees : CGFloat = transration.x / 20
        let angle = degrees * .pi / 180
        let rotatationalTransform = CGAffineTransform(rotationAngle: angle)
        
        self.transform = rotatationalTransform.translatedBy(x: transration.x, y: transration.y)
    }
    
    private func resetCardPosition(sender : UIPanGestureRecognizer) {
        
        let direction : swipeDirection = sender.translation(in: nil).x > 100 ? .rigt : .left
        let showldDismissCard = abs(sender.translation(in: nil).x) > 150
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if showldDismissCard {
                
                /// dismiss Card
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let ofScreenTranform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = ofScreenTranform
            } else {
                self.transform = .identity
            }
            
            
        }) { (_) in
            
            if showldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
}
