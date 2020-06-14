//
//  CardView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage

enum swipeDirection : Int {
    case left = -1
    case rigt = 1
}

protocol CardViewDelegate : class {
    func handleShowProfile(view : CardView, user : User)
    func handleLikeCation(view : CardView, didLikeUser :Bool)
}

class CardView : UIView {
    
    weak var delegate : CardViewDelegate?
    
    //MARK: - Parts
    
    private let gradientLayer = CAGradientLayer()
    private let barStackView = UIStackView()
    
    let viewModel : CardViewModel
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText
        
        return label
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleInfo), for: .touchUpInside)
        
        return button
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(profileImageView)
        profileImageView.fillSuperview()
        
        profileImageView.sd_setImage(with: viewModel.imageUrl)
        
        configureBarStackVIew()
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
    
    @objc func handleInfo() {
        
        delegate?.handleShowProfile(view: self, user: viewModel.user)
    }
    
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
        /// next Picture via TapGesture
        
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        
        /// change Photo
//        profileImageView.image = viewModel.imageToShow
        
        profileImageView.sd_setImage(with: viewModel.imageUrl)
        
        barStackView.arrangedSubviews.forEach({$0.backgroundColor = .barDeselectedColor})
        barStackView.arrangedSubviews[viewModel.index].backgroundColor = .white
        
    }
    
    //MARK: - Helpers
    
    private func configureBarStackVIew() {
        
        (0 ..< viewModel.imageUrls.count).forEach { (_) in
            
            let barView = UIView()
            barView.backgroundColor = UIColor.barDeselectedColor
            
            barStackView.addArrangedSubview(barView)
        }
        
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        
        addSubview(barStackView)
        barStackView.anchor(top : topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 8,paddingRight: 8,height: 4)
        
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        
    }
    
    private func configureGradientLayer() {
        /// add gesture
        configGestureRecoganaizer()
        
        /// set ViewModel
        
        profileImageView.sd_setImage(with: viewModel.imageUrl)
        
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
                let didLike = direction == .rigt
                self.delegate?.handleLikeCation(view: self, didLikeUser: didLike)
//                self.removeFromSuperview()
            }
        }
    }
    
}
