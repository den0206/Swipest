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
    
    private var viewModels = [CardViewModel]() {
        didSet {
            
            configureCards()
        }
    }
    
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

        
//        logOut()
        
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack ,deckView ,bottomStack])
        
        topStack.delegate = self
        
        stack.axis = .vertical

        view.addSubview(stack)
        stack.anchor(top : view.safeAreaLayoutGuide.topAnchor,left : view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
        
    }
    
    private func configureCards() {
        
        viewModels.forEach { (vm) in
            
            let cardView = CardView(viewModel: vm)
            
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        

    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            
            presentLoginVC()
            
            
        } else {
            /// already  log ins
            
            fetchUsers()
            
        }
    }

    
    func fetchUsers() {
        Service.fetchUsers { (users) in
            self.viewModels = users.map({CardViewModel(user: $0)})
            
//            var vms = [CardViewModel]()
//            users.forEach { (user ) in
//                let vm = CardViewModel(user: user)
//                vms.append(vm)
//
//                if users.count == vms.count {
//
//                    self.viewModels = vms
//                }
//            }
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


extension HomeController : HomeNavigationStackViewDelegate {

    func presentSettingPage() {
        
        let settingVC = SettingViewController()
        
        let nav = UINavigationController(rootViewController: settingVC)
        nav.modalPresentationStyle = .fullScreen
        present( nav, animated: true, completion: nil)
    }
    
    func presentMessage() {
        print("Message")
    }
    
    
    
}
