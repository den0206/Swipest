//
//  HomeController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/03.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase

class HomeController : UIViewController {
    
    //MARK: - Parts
    private let topStack = HomeNavigationStackView()
    
    private let deckView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let bottomStack = BottomControlsStackView()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()

        configureUI()
        configureCards()
        
        
//        logOut()
        
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack ,deckView ,bottomStack])
        
        stack.axis = .vertical

        view.addSubview(stack)
        stack.anchor(top : view.safeAreaLayoutGuide.topAnchor,left : view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
        
    }
    
    private func configureCards() {
        let user1 = User(name: "Yuuki", age: 29, images: [#imageLiteral(resourceName: "kelly1"),#imageLiteral(resourceName: "jane3")])
        let user2 = User(name: "Ami", age: 28, images: [#imageLiteral(resourceName: "kelly3"),#imageLiteral(resourceName: "kelly2")])
        
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        
        
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            
            presentLoginVC()
            
            
        } else {
            /// already  log ins
            
            print("Already")
        }
    }
    
    func logOut() {
        
        do {
            try Auth.auth().signOut()
            presentLoginVC()
        } catch {
            print("Can't Log out")
        }
    }
    
    func presentLoginVC() {
        DispatchQueue.main.async {
            let loginVC = LoginController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}
