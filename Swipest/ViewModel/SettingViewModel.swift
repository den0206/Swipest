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
    case ageRange
    
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
        case .ageRange:
            return "Seeking Age Range"
        }
    }
}


struct SettingViewModel {
    
    private let user : User
    private let section : settingSections
    
    var shoulHideInputField : Bool {
        return section == .ageRange
    }
    
    var shoulHideSlidr : Bool {
        return section != .ageRange
    }
    
    let placeHolderText : String
    var value : String?
    
    init(user : User, section : settingSections) {
        
        self.user = user
        self.section = section
        
        placeHolderText = "Enter \(section.description)"
        
        switch section {
       
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .age:
            value = "\(user.age)"
        case .bio:
            value = user.bio
        case .ageRange:
            break
        }
    }
}
