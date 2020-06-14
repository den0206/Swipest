//
//  FirebaseReference.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import FirebaseFirestore

enum Reference : String {
    case User
    case Swipe
}

func firebaseReference(_ reference : Reference) -> CollectionReference {
    
    return Firestore.firestore().collection(reference.rawValue)
}
