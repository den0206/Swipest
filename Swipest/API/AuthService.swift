//
//  AuthService.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredential {
    
    let email : String
    let fullname : String
    let password : String
    let profileImage : UIImage
}

struct AuthService {
    
    
    static func registerUser(credential : AuthCredential, completion :  @escaping(Error?) -> Void) {
        
        /// get utlString
        Service.uploadImage(image: credential.profileImage) { (imageUrl) in
            
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { (result, error) in
                
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let values : Dictionary = [
                    kEMAIL : credential.email,
                    kFULLNAME : credential.password,
                    kUSERID : uid,
                    kPROFILE_IMAGES : [imageUrl],
                    kAGE : 18
                    ] as [String : Any]
                
                firebaseReference(.User).document(uid).setData(values, completion: completion)
            }
            
        }
    }
    
    static func loginUser(email : String, password : String, completion : AuthDataResultCallback? ) {
        
//        Auth.auth().signIn(withEmail: email, link: password, completion: completion)
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
