//
//  SettingCell.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SettingCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
