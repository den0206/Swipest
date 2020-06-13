//
//  ProfileCell.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: - Parts
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
