//
//  SettingViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum settingSections : Int, CaseIterable{
    case name
    case profession
    case age
    case bio
    case agerTange
    
    var description : String {
        switch self {
    
        case .name:
            return "Name"
        case .profession:
            return "Profession"
        case .age:
            return "Age"
        case .bio:
            return "Bio"
        case .agerTange:
            return "Seeking Age Range"
        }
    }
}


struct SettingViewModel {
    
}
