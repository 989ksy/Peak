//
//  RecommendationCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/26/23.
//

import UIKit
import SnapKit

class RecommendationCell : BaseCollectionViewCell {
    
    static let identifier = "RecommendationCell"
    
    let wordLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0  // 여러 줄 허용
        view.text = "테스트"
        view.font = ConstantFont.bd14
        view.textColor = .darkGray
        return view
    }()
    
    override func configureView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubview(wordLabel)
    }
    
    override func setConstraints() {
        
        
        wordLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
}
