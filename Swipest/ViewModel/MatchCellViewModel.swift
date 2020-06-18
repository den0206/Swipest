//
//  MatchCellViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/18.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct MatchCellViewModel {
    
    let nameText : String
    let profileImageUrl : URL?
    let uid : String
    
    init(match : Match) {
        nameText = match.name
        profileImageUrl = URL(string: match.profileImageUrl)
        uid = match.uid
    }
}
