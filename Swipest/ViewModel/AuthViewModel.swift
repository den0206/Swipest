//
//  AuthViewModel.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/06.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    var email : String?
    var password : String?
    
    var formValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
}

struct RegistrationViewModel {
    
    var email : String?
    var fullname : String?
    var password : String?
    
    var formValid : Bool {
        return email?.isEmpty == false && fullname?.isEmpty == false &&
            password?.isEmpty == false
    }
    
    
    
}
