//
//  Match.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/17.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct Match {
    
    let name : String
    let profileImageUrl : String
    let uid : String
    
    init(dictionary : [String : Any]) {
        
        self.name = dictionary[kFULLNAME] as? String ?? ""
        self.profileImageUrl = dictionary[kPROFILE_IMAGES] as? String ?? ""
        self.uid = dictionary[kUSERID] as? String ?? ""
    }
}
