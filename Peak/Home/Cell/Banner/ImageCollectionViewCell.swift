//
//  ImageCollectionViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//


import UIKit
import SnapKit

class ImageCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    let uploadedImaegView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let countBackView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.Baige?.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let countLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = ConstantFont.reg14
        view.textAlignment = .center
        return view
    }()
    
    
    override func configureView() {
        
        addSubview(uploadedImaegView)
        addSubview(countBackView)
        countBackView.addSubview(countLabel)
        
    }
    
    override func setConstraints() {
        
        uploadedImaegView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        countBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(28)
            make.width.equalTo(43)
            make.trailing.equalToSuperview().inset(12)
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()

        }
        
    }
    
}
