//
//  BannerTableViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//

import UIKit
import SnapKit

class BannerTableViewCell : BaseTableViewCell {
    
    static let identifier = "BannerTableViewCell"
    
    let slideCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(SlideCollectionViewCell.self, forCellWithReuseIdentifier: SlideCollectionViewCell.identifier)
        view.isScrollEnabled = false
        view.isPagingEnabled = true
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: width , height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
    
    override func configureView() {
        
        contentView.addSubview(slideCollectionView)
        slideCollectionView.dataSource = self
        slideCollectionView.delegate = self
        
        slideCollectionView.backgroundColor = .yellow
    }
    
    override func setConstraints() {
        slideCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension BannerTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.identifier, for: indexPath) as? SlideCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
