//
//  CardViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class CardViewModel {
    
    let user : User
    let imageUrls : [String]
    
    let userInfoText : NSAttributedString
    
    private var imageIndex = 0
    var index : Int {
        return imageIndex
    }
    var imageUrl : URL?
    
    init(user : User) {
        
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy), NSAttributedString.Key.foregroundColor : UIColor.white])
        
        attributedText.append(NSMutableAttributedString(string: "  \(user.age)", attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        
        
        self.userInfoText = attributedText
        
    
        self.imageUrls = user.profileImageUrl
        self.imageUrl = URL(string: user.profileImageUrl[0])
         
    }
    
    func showNextPhoto() {

        guard imageIndex < imageUrls.count - 1 else {return}

        imageIndex += 1
        imageUrl = URL(string: imageUrls[imageIndex])
    }
    
    func showPreviousPhoto() {
        
        guard imageIndex > 0 else {return}

        imageIndex -= 1
        imageUrl = URL(string: imageUrls[imageIndex])
        
    }
}
