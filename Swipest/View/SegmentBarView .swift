//
//  SegmentBarView .swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SegmentStackView : UIStackView{
    
    init(numberOfSections : Int) {
        super.init(frame: .zero)
        
        (0 ..< numberOfSections).forEach { (_) in
            
            let barView = UIView()
            barView.backgroundColor = UIColor.barDeselectedColor
            
            addArrangedSubview(barView)
        }
        
        spacing = 4
        distribution = .fillEqually
        
        arrangedSubviews.first?.backgroundColor = .white
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHighLighted(index : Int) {
        
        arrangedSubviews.forEach({$0.backgroundColor = .barDeselectedColor})
        arrangedSubviews[index].backgroundColor = .white
    }
}
