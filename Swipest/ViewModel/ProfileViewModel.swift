//
//  ProfileViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

struct ProfileViewModel {
    
    private let user : User
    
    let userDetailAttributeString : NSAttributedString
    
    var professerString : String {
        return user.profession
    }
    
    var bioString : String {
        return user.bio
    }
        
    var imageURLs : [URL] {
        return user.profileImageUrl.map({URL(string: $0)!})
    }
    
    var itemCount : Int {
        return user.profileImageUrl.count
    }
    
    
    
    init(user : User) {
        self.user = user
        
        let atteributeString = NSMutableAttributedString(string: user.name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight : .heavy)])
        
        atteributeString.append(NSAttributedString(string: " \(user.age)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)]))
        
        userDetailAttributeString = atteributeString
    }
}
