//
//  MatchView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/14.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class MatchView : UIView {
    
    private let currentUser : User
    private let matchUser : User
    
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
        label.text = "\(matchUser.name) さんと マッチしました."
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
        button.addTarget(self, action: #selector(didTapSwiping), for: .touchUpInside)
        return button
    }()
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var views = [
        matchImageView,descriptonLabel,currentUserImageView,matchUserImageView,sendMessageButton,keepSwipingButton
    ]
    
    
    //MARK: - Init
    
    init(currentUser : User, matchUser : User) {
        self.currentUser = currentUser
        self.matchUser = matchUser
        
        super.init(frame: .zero)
        
        configureBlurView()
        configureUI()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    @objc func didTapMessage() {
        print("Mess")
    }
    
    @objc func didTapSwiping() {
        print("Swip")
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
            view.alpha = 1
        }
        
        /// set constraits (based imageView)
        currentUserImageView.anchor(left : centerXAnchor, paddingLeft: 16)
        currentUserImageView.centerY(inView: self)
        matchUserImageView.anchor(right : centerXAnchor, paddingRight: 16)
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
    
   
}
