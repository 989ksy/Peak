//
//  FavoriteView.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/08.
//

import UIKit

class FavoriteView : BaseView {
    
    // 컬렉션뷰 세팅
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) //양 끝쪽 여백
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size/2, height: size/1.5)
        return layout
        
    }
    
    
    //뷰 객체
    
    let searchbar = {
        let view = UISearchBar()
        view.barTintColor = .clear
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "상품을 검색해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray4])
        view.searchTextField.leftView?.tintColor = .white
        view.searchTextField.textColor = .white
        view.searchTextField.backgroundColor = .darkGray
        view.tintColor = .white
        view.showsCancelButton = true
        return view
    }()
    
    
    
    
    override func configureView() {
        
        addSubview(searchbar)
        addSubview(collectionView)
        collectionView.backgroundColor = .black
        
    }
    
    
    
    override func setConstraints() {
        searchbar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
}
