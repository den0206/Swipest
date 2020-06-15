//
//  MatchViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct MatchViewModel {
    
    let currentUser : User
    let matchUser : User
    
    let matchLabelText : String
    
    var currentUserImageUrl : URL?
    var matchUserImageUrl : URL?
    
    
    init(currentUser : User, matchUser : User) {
        self.currentUser = currentUser
        self.matchUser = matchUser
        
        self.matchLabelText = "\(matchUser.name) さんと マッチしました."
        
        guard let currentImageString = currentUser.profileImageUrl.first else {return}
        guard let matchIMageString = matchUser.profileImageUrl.first else {return}
        self.currentUserImageUrl = URL(string: currentImageString)
        self.matchUserImageUrl = URL(string: matchIMageString)

    }
}
