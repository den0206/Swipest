//
//  MatchHeaderView.swift
//  Swipest
//
//  Created by 酒井ゆうき on 2020/06/17.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
private let reuseIdentifer = "MatchCell"

protocol MatchHeaderViewDelegate : class {
    func matchHeader(_ header : MatchHeaderView, mathedUID : String)
}

class MatchHeaderView : UICollectionReusableView {
    
    var delegate : MatchHeaderViewDelegate?
    
    var matches = [Match]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let newMatchesLabel : UILabel = {
        
        let label = UILabel()
        label.text = "New Matches"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return label
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        
        addSubview(newMatchesLabel)
        newMatchesLabel.anchor(top : topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 12)
        
        addSubview(collectionView)
        collectionView.anchor(top :newMatchesLabel.bottomAnchor,left:  leftAnchor, bottom : bottomAnchor ,right: rightAnchor,paddingTop: 4, paddingLeft: 12, paddingBottom: 24, paddingRight: 12)
        
        
        configCV()
        
    }
    
    //MARK: - UI
    
    private func configCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: reuseIdentifer)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MatchHeaderView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! MatchCell
        
        let viewModel = MatchCellViewModel(match: matches[indexPath.item])
        cell.viewModel = viewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let uid = matches[indexPath.item].uid
        
        delegate?.matchHeader(self, mathedUID: uid)
    }
    
}

extension MatchHeaderView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 120)
    }
}
