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
    
    static func fetchUsers(currentUser : User, completion :  @escaping([User]) -> Void) {
        
        var users = [User]()
        
        /// filter
        let minAge = currentUser.minSeekingAge
        let maxAge = currentUser.maxSeekingAge
        
        let query = firebaseReference(.User).whereField(kAGE, isGreaterThanOrEqualTo:  minAge).whereField(kAGE, isLessThanOrEqualTo : maxAge)
        
        query.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                for doc in snapshot.documents {
                    
                    let dic = doc.data()
                    let user = User(dictionary: dic)
                    
                    /// expect currentUser
                    guard user.uid != Auth.auth().currentUser?.uid else { return }
                    
                    users.append(user)
                    
                    /// avoid multipleTime
                    if users.count  == snapshot.documents.count - 1 {
                        completion(users)
                    }
                    
                }
                
//                completion(users)

            }
        }
        
        
    }
    
    //MARK: - Helpers
    
    static func saveUserDate(user : User, completion :  @escaping(Error?) -> Void) {
        
        print(user)
        let date = [kUSERID :user.uid,
                    kFULLNAME : user.name,
                    kPROFILE_IMAGES : user.profileImageUrl,
                    kAGE : user.age,
                    kBIO : user.bio,
                    kPROFESSION : user.profession,
                    kMIMSEEKING : user.minSeekingAge,
                    kMAXSEEKING : user.maxSeekingAge
            ] as [String : Any]
        
//        print(date)
        
        firebaseReference(.User).document(user.uid).updateData(date, completion: completion)
        
    }
    
    
    static func saveSwipe(user : User, isLike : Bool) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
//        let shouldLike = isLike ? 1 : 0
        
        firebaseReference(.Swipe).document(uid).getDocument { (snapshot, error) in
            
            let date = [user.uid : isLike]
            
            guard let snapshot = snapshot else {return}
            
            if snapshot.exists {
                firebaseReference(.Swipe).document(uid).updateData(date)
            } else {
                firebaseReference(.Swipe).document(uid).setData(date)

            }
        }
    }
    
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
