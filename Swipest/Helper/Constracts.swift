//
//  Constracts.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import Firebase



public let kSTOROGE_REF = Storage.storage().reference()
public let kSTOROGE_PROFILE_REF = kSTOROGE_REF.child(kPROFILE_IMAGES)


//MARK: - User

public let kUSERID = "userID"
public let kEMAIL = "email"
public let kPASSWORD = "password"
public let kPROFILE_IMAGES = "profileImages"
public let kFULLNAME = "fullname"
public let kBIO = "bio"
public let kPROFESSION = "profession"
public let kMIMSEEKING = "minSeekingAge"
public let kMAXSEEKING = "maxSeekingAge"
public let kAGE = "age"
public let kFOLLOWING = "FOLLOWING"
public let kFOLLOWERS = "FOLLOWER"

//MARK: - Collection

public let kMATCHES = "Matches"
