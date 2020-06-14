//
//  ProfileController.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "ProfileCell"
class ProfileController : UIViewController {
    
    let user : User
    
    private lazy var viewModel = ProfileViewModel(user : user)
    private lazy var barStackView = SegmentStackView(numberOfSections: viewModel.imageURLs.count)
    
    //MARK: - Parts
    private lazy var collectioView : UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + 100)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let blueView : UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.setDimensions(height: 40, width: 40)
        return button
    }()
    
    /// Labels
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)

        return label
    }()
    
    private let profossionLabel : UILabel = {
        let label = UILabel()
        label.text = "profesison"
        label.font = UIFont.systemFont(ofSize: 20)

        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "bio"
        return label
    }()
    
    /// buttons
    
    lazy var disLikeButton : UIButton = {
        
        let button = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
        button.addTarget(self, action: #selector(handleDisLike), for: .touchUpInside)
        return button
    }()
    
    lazy var superLikeButton : UIButton = {
        let button = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
        button.addTarget(self, action: #selector(handleSuperLike), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton : UIButton = {
        let button = createButton(image: #imageLiteral(resourceName: "like_circle"))
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    

    init(user : User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        loadUserDate()

    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.backgroundColor = .white
        view.addSubview(collectioView)
        collectioView.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifer)

        
        view.addSubview(dismissButton)
        dismissButton.anchor(top : collectioView.bottomAnchor,right: view.rightAnchor,paddingTop: -20,paddingRight:  16)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel,profossionLabel,bioLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        
        view.addSubview(infoStack)
        infoStack.anchor(top : collectioView.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingTop: 12, paddingLeft: 12,paddingRight: 12)
        
        view.addSubview(blueView)
        blueView.anchor(top : view.topAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor)
        
        configureBottomControls()
        
        configureBarStackView()
        
    }
    
    private func configureBottomControls() {
        
        let stack = UIStackView(arrangedSubviews: [disLikeButton,superLikeButton,likeButton])
        stack.distribution = .fillEqually
        stack.spacing = -32
        
        view.addSubview(stack)
        stack.setDimensions(height: 80, width: 300)
        stack.centerX(inView: view)
        stack.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 32)
    }
    
    private func configureBarStackView() {
        view.addSubview(barStackView)
        barStackView.anchor(top : view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 56,paddingLeft: 8,paddingRight: 8,height: 4)
        
    }
    
    func createButton(image : UIImage) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill

        return button
    }
    
    func loadUserDate() {
        infoLabel.attributedText = viewModel.userDetailAttributeString
        
        profossionLabel.text = viewModel.professerString
        bioLabel.text = viewModel.bioString
    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// buttons Actiuon
    
    @objc func handleDisLike() {
        
    }
    
    @objc func handleSuperLike() {
        
    }
    
    @objc func handleLike() {
        
    }
}

extension ProfileController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! ProfileCell
        
        cell.imageView.sd_setImage(with: viewModel.imageURLs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        barStackView.setHighLighted(index: indexPath.row)
    }
    
    
}

extension ProfileController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
