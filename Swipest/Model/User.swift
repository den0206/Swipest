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
    let profileImageUrl : String
    
    init(dictionary : [String : Any]) {
        
        self.name = dictionary[kFULLNAME] as? String ?? ""
        self.age = dictionary[kAGE] as? Int ?? 18
        self.email = dictionary[kEMAIL] as? String ?? ""
        self.uid = dictionary[kUSERID] as? String ?? ""
        self.profileImageUrl = dictionary[kPROFILE_IMAGE] as? String ?? ""
        
    }
   
}
