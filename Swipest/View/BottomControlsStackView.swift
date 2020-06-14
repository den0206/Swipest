//
//  BottomControlsStackView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//



import UIKit

protocol BottomControlsStackViewDelegate :class {
    
    func handleLike()
    func handleDislike()
    func handleRefresh()
}

class BottomControlsStackView : UIStackView {
    
    weak var delegate : BottomControlsStackViewDelegate?
    //MARK: - parts
    
    let refreshButtton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superLikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
        
        refreshButtton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superLikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        
        dislikeButton.addTarget(self, action: #selector(handleDisLike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        refreshButtton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)



        
        [refreshButtton,dislikeButton, superLikeButton,likeButton,boostButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleDisLike() {
        delegate?.handleDislike()
    }
    
    @objc func handleLike() {
        delegate?.handleLike()
    }
    
    @objc func handleRefresh() {
        delegate?.handleRefresh()
    }

}
