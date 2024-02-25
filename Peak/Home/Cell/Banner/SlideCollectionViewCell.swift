//
//  SlideCollectionViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//

import UIKit
import SnapKit

class SlideCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "SlideCollectionViewCell"
    
    let imageList = [UIImage(named: "CampingImage1"), UIImage(named: "CampingImage2"), UIImage(named: "CampingImage3")]
    
    let imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 0
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width , height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    override func configureView() {
        
        contentView.addSubview(imageCollectionView)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    override func setConstraints() {
        
        imageCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
}


//MARK: - 이미지 슬라이드 설정 (Cell)

extension SlideCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    //셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath) as? ImageCollectionViewCell
        else { return UICollectionViewCell() }
        
        let data = imageList[indexPath.item]
        
        DispatchQueue.main.async {
            cell.uploadedImaegView.image = data
            cell.countBackView.backgroundColor = .darkGray.withAlphaComponent(0.5)
            cell.countLabel.text = "\(indexPath.row + 1)/\(self.imageList.count)"
        }
        
        return cell
    }
    
    
    
    
}
