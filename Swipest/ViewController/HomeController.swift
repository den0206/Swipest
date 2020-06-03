//
//  HomeController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class HomeController : UIViewController {
    
    //MARK: - Parts
    private let topStack = HomeNavigationStackView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topStack)
        topStack.anchor(top : view.safeAreaLayoutGuide.topAnchor,left : view.leftAnchor,right: view.rightAnchor)
    }
}
