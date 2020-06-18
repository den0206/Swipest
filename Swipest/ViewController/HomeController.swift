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
    
    private var user : User?
    
    //MARK: - Parts
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    private var topCardView : CardView?
    private var cardViews = [CardView]()

    private let deckView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
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
        bottomStack.delegate = self
        
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
            
            cardView.delegate = self
//            cardViews.append(cardView)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
         
        cardViews = deckView.subviews.map({($0 as? CardView)!})
        print(cardViews)
        topCardView = cardViews.last
        
        

    }
    
    func performSwipeAnimation(sholdLIke : Bool) {
        
        let translation : CGFloat = sholdLIke ? 700 : -700
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            /// swipe Animartion
            self.topCardView?.frame = CGRect(x: translation, y: 0, width: (self.topCardView?.frame.width)!, height: (self.topCardView?.frame.height)!)
            
        }) { (_) in
            self.topCardView?.removeFromSuperview()
            
            
            guard !self.cardViews.isEmpty else {return}
            
            self.cardViews.remove(at: self.cardViews.count - 1)
            self.topCardView = self.cardViews.last
        }
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            
            presentLoginVC()
            
            
        } else {
            /// already  log ins
            
            fetchCurrentUserAndCards()
            
        }
    }
    


    
    func fetchUsers(currentUser : User) {
        
        Service.fetchUsers(currentUser: currentUser) { (users) in
            
            self.viewModels = users.map({CardViewModel(user: $0)})
        }
//        Service.fetchUsers { (users) in
//            self.viewModels = users.map({CardViewModel(user: $0)})
//
////            var vms = [CardViewModel]()
////            users.forEach { (user ) in
////                let vm = CardViewModel(user: user)
////                vms.append(vm)
////
////                if users.count == vms.count {
////
////                    self.viewModels = vms
////                }
////            }
//        }
    }
    
    func fetchCurrentUserAndCards() {
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        /// set current User
        Service.fetchUser(uid: currentId) { (user) in
            
            self.user = user
            /// sert vardViewModels
            self.fetchUsers(currentUser: user)
        }
    }
    
    func saveSwipeAndCheckMatch(forUser user: User, didLike : Bool) {
        
        Service.saveSwipe(user: user, isLike: didLike) { (error) in
            
            self.topCardView = self.cardViews.last
            
            guard didLike == true else {return}
            
            Service.checkMatchExist(user: user) { (didMatch) in
                
                self.presentMatchView(matchUser: user)
                
                /// add Firestore each user
                guard let currentUser = self.user else {return}
                
                Service.uploadMatch(currentUser: currentUser, mathedUser: user)
                
            }
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
            loginVC.delegate = self
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func presentMatchView(matchUser : User) {
        guard let currentUser = self.user else {return}
        let viewModel = MatchViewModel(currentUser: currentUser, matchUser: matchUser)
        let matchVC = MatchView(viewModel: viewModel)
        matchVC.delegate = self
        
        view.addSubview(matchVC)
        matchVC.fillSuperview()
    }
}


extension HomeController : HomeNavigationStackViewDelegate {

    func presentSettingPage() {
        
        guard let user = self.user else {return}
        
        let settingVC = SettingViewController(user: user)
        settingVC.delegate = self
        
        let nav = UINavigationController(rootViewController: settingVC)
        nav.modalPresentationStyle = .fullScreen
        present( nav, animated: true, completion: nil)
    }
    
    func presentMessage() {
        guard let user = user else {return}
        let messageVC = MessagesController(user: user)
        let nav = UINavigationController(rootViewController: messageVC)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    
}

extension HomeController : CardViewDelegate {
    
    /// swipe like
    func handleLikeCation(view: CardView, didLikeUser: Bool) {
        
        view.removeFromSuperview()
        /// remov self cardViews
        self.cardViews.removeAll(where: {view == $0})
        
        guard let user = topCardView?.viewModel.user else {return}
        saveSwipeAndCheckMatch(forUser: user, didLike: didLikeUser)
        
        self.topCardView = cardViews.last
    }
    
    func handleShowProfile(view: CardView, user: User) {
        
        let profileVC = ProfileController(user: user)
        profileVC.delegate = self
        profileVC.modalPresentationStyle = .fullScreen
        
        present(profileVC, animated: true, completion: nil)
    }
    
    
}

extension HomeController : SettingViewControllerDelegate {
    func handleLogout(_ controller: SettingViewController) {
        controller.dismiss(animated: true, completion: nil)
        logOut()
    }
    
    func settingController(_ controller: SettingViewController, user: User) {
        
        /// update
        controller.dismiss(animated: true, completion: nil)
        self.user = user
    }
    
    
}

//MARK: - Button Actuions

extension HomeController : BottomControlsStackViewDelegate {
    
    func handleLike() {
        
        guard let topCard = topCardView else {return}
        
        performSwipeAnimation(sholdLIke: true)
        saveSwipeAndCheckMatch(forUser: topCard.viewModel.user, didLike: true)
        
        
//
//        guard !cardViews.isEmpty else {return}
//
//        cardViews.remove(at: cardViews.count - 1)
//        topCardView = cardViews.last
        
    }
    
    func handleDislike() {
        guard let topCard = topCardView else {return}

        performSwipeAnimation(sholdLIke: false)
        Service.saveSwipe(user: topCard.viewModel.user, isLike: false, completion: nil)


    }
    
    func handleRefresh() {
        /// reset
        guard let user = self.user else {return}
        Service.fetchUsers(currentUser: user) { (users) in
            
            self.viewModels = users.map({CardViewModel(user: $0)})
            
        }
    }
    
    
}

//MARK: - Profile Conrtroller Delegate

extension HomeController : ProfileControllerDelegate {
    func handleLike(profileVC: ProfileController, likeUser: User) {
        
        /// profile Button
        profileVC.dismiss(animated: true) {
            self.performSwipeAnimation(sholdLIke: true)

            self.saveSwipeAndCheckMatch(forUser: likeUser, didLike: true)
        }

    }
    
    func handleDisLike(profileVC: ProfileController, disLikeUser: User) {
        
        profileVC.dismiss(animated: true) {
            
            self.performSwipeAnimation(sholdLIke: false)

            Service.saveSwipe(user: disLikeUser, isLike: false, completion: nil)

        }

    }
    
    
}

extension HomeController :  MatchViewDelegate {
    func tappedMessage(_ view: MatchView, sendToUser: User) {
        /// present MessageVC
        print(sendToUser.name)
    }
    
    
}
//MARK: - Auth Delegate

extension HomeController : AuthDelegate {
    func AuthComplete() {
        
        dismiss(animated: true, completion: nil)
        fetchCurrentUserAndCards()
    }
    
    
}

