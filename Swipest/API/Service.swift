//
//  Service.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUser(uid : String, completion :  @escaping(User) -> Void) {
        
        firebaseReference(.User).document(uid).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if snapshot.exists {
                guard let dic = snapshot.data() else {return}
                let user = User(dictionary: dic)
                
                completion(user)
            }
        }
    }
    
    static func fetchUsers(completion :  @escaping([User]) -> Void) {
        
        var users = [User]()
        
        firebaseReference(.User).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                for doc in snapshot.documents {
                    
                    let dic = doc.data()
                    let user = User(dictionary: dic)
                    
                    users.append(user)
                    
                    /// avoid multipleTime
                    if users.count == snapshot.documents.count {
                        completion(users)
                    }
                    
                }
                
//                completion(users)

            }
        }
        
        
    }
    
    //MARK: - Helpers
    
    static func uploadImage(image : UIImage, completion :  @escaping(String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
        
        let fileName = NSUUID().uuidString
        let ref = kSTOROGE_PROFILE_REF.child(fileName)
        
        ref.putData(imageData, metadata: nil) { (metaData, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            ref.downloadURL { (url, error) in
                
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
            
        }
    }
}
