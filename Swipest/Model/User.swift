//
//  User.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

struct User {
    var name : String
    var age : Int
    
    let email : String
    let uid : String
    var profileImageUrl : [String]
    var profession : String
    var bio : String
    var minSeekingAge : Int = 18
    var maxSeekingAge = 40
    
    
    init(dictionary : [String : Any]) {
        
        self.name = dictionary[kFULLNAME] as? String ?? ""
        self.age = dictionary[kAGE] as? Int ?? 18
        self.email = dictionary[kEMAIL] as? String ?? ""
        self.uid = dictionary[kUSERID] as? String ?? ""
        self.bio = dictionary[kBIO] as? String ?? ""
        self.profileImageUrl = dictionary[kPROFILE_IMAGES] as? [String] ?? [String]()
        self.profession = dictionary[kPROFESSION] as? String ?? ""
        self.minSeekingAge = dictionary[kMIMSEEKING] as? Int ?? 18
        self.maxSeekingAge = dictionary[kMIMSEEKING] as? Int ?? 40
        
        
    }
   
}
