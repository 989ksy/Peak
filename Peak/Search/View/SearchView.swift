//
//  SearchView.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/26/23.
//

import UIKit
import SnapKit

class SearchView : BaseView {
        
    let searchBar = {
        let bar = SearchbarCustom()
        return bar
    }()
    
    let recommendationLabel = {
        let label = UILabel()
        label.text = "피크 추천 검색어"
        label.font = ConstantFont.extrabd15
        return label
    }()
    
    lazy var recommendCollectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 7, left: 8, bottom: 8, right: 4)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = layout
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: "RecommendationCell")
        
        return collectionView
    }()
    
    let hotSearchLabel = {
        let label = UILabel()
        label.text = "급상승 검색어"
        label.font = ConstantFont.extrabd15
        return label
    }()
    
    let hotDescriptionLabel = {
        let label = UILabel()
        label.text = "최근 1시간 동안 검색 횟수가 급상승했어요"
        label.font = ConstantFont.bd13
        label.textColor = .lightGray
        return label
    }()
    
    let hotSearchTableView = {
        let view = UITableView()
        view.register(HotSearchTableViewCell.self, forCellReuseIdentifier: HotSearchTableViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    override func configureView() {
        
        addSubview(recommendationLabel)
        addSubview(recommendCollectionView)
        
        addSubview(hotSearchLabel)
        addSubview(hotDescriptionLabel)
        addSubview(hotSearchTableView)
        
        
    }
    
    override func setConstraints() {
        
        recommendationLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(13)
            make.leading.equalToSuperview().offset(17)
            make.height.equalTo(15)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendationLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(136)
        }
        
        hotSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendCollectionView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(17)
            make.height.equalTo(15)
        }
        
        hotDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(hotSearchLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(17)
            make.height.equalTo(15)
        }
        
        hotSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(hotDescriptionLabel.snp.bottom).offset(11)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}
