//
//  MatchView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage

protocol MatchViewDelegate : class {
    func tappedMessage(_ view : MatchView, sendToUser : User)
}

class MatchView : UIView {
    
    private let viewModel : MatchViewModel
    weak var delegate : MatchViewDelegate?
    
//    private let currentUser : User
//    private let matchUser : User
    
    //MARK: - Parts
    
    private let matchImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "itsamatch")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var descriptonLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let currentUserImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "kelly1")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.setDimensions(height: 140, width: 140)
        iv.layer.cornerRadius = 140 / 2
        iv.layer.borderWidth = 2
        return iv
    }()
    
    private let matchUserImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "jane2")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.setDimensions(height: 140, width: 140)
        iv.layer.cornerRadius = 140 / 2
        iv.layer.borderWidth = 2
        return iv
    }()
    
    private let sendMessageButton : UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapMessage), for: .touchUpInside)
        return button
    }()
    
    private let keepSwipingButton : UIButton = {
        let button = KeepSwipingButton(type: .system)
        button.setTitle("Keep Swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var views = [
        matchImageView,descriptonLabel,currentUserImageView,matchUserImageView,sendMessageButton,keepSwipingButton
    ]
    
    
    //MARK: - Init
    
    init(viewModel : MatchViewModel) {
        
        self.viewModel = viewModel
//        self.currentUser = currentUser
//        self.matchUser = matchUser
  
        
        super.init(frame: .zero)
        
        loadUserDate()

        
        configureBlurView()
        configureUI()
        configureAnimations()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    @objc func didTapMessage() {
        delegate?.tappedMessage(self, sendToUser: viewModel.matchUser)
    }
    
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: - UI
    
    private func configureUI() {
        /// all parts
        views.forEach { (view) in
            addSubview(view)
            view.alpha = 0
        }
        
        /// set constraits (based imageView)
        currentUserImageView.anchor(right : centerXAnchor, paddingRight:  16)
        currentUserImageView.centerY(inView: self)
        matchUserImageView.anchor(left : centerXAnchor, paddingLeft:  16)
        matchUserImageView.centerY(inView: self)
        
        sendMessageButton.anchor(top : currentUserImageView.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 32,paddingLeft: 48,paddingRight: 48)
        sendMessageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        keepSwipingButton.anchor(top : sendMessageButton.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 48,paddingRight: 48)
        keepSwipingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        descriptonLabel.anchor(left : leftAnchor,bottom: currentUserImageView.topAnchor, right: rightAnchor,paddingBottom: 32)
        
        matchImageView.anchor(bottom :descriptonLabel.topAnchor,paddingBottom: 16)
        matchImageView.setDimensions(height: 80, width: 300)
        matchImageView.centerX(inView: self)
        
        
        
        
        
    }
    
    func loadUserDate() {
        descriptonLabel.text = viewModel.matchLabelText
        
        currentUserImageView.sd_setImage(with: viewModel.currentUserImageUrl)
        matchUserImageView.sd_setImage(with: viewModel.matchUserImageUrl)

    }
    
    /// dark blurView
    
    func configureBlurView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        visualEffectView.addGestureRecognizer(tap)
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 1
        }, completion: nil)
    }
    
    func configureAnimations() {
        views.forEach { (view) in
            view.alpha = 1
        }
        
        let angle = 30 * CGFloat.pi / 180
        
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        matchUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        
        sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
        keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)

        UIView.animateKeyframes(withDuration: 1.3, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.matchUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                
                self.currentUserImageView.transform = .identity
                self.matchUserImageView.transform = .identity
            }
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0.6 * 1.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.sendMessageButton.transform = .identity
            self.keepSwipingButton.transform = .identity
        }, completion: nil)
    }
   
}
