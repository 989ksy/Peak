//
//  SearchCollectionViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit
import SnapKit
import RealmSwift


class SearchingCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "SearchingCollectionViewCell"
        
    let productImage = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let likeButton = {
        let view = UIButton()
        view.layer.cornerRadius = 20
        view.backgroundColor = ConstantColor.Green?.withAlphaComponent(0.7)
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    let storeNameLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = ConstantFont.reg12
        return view
    }()
    let productNameLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = ConstantFont.reg14
        return view
    }()
    let priceLabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.font = ConstantFont.extrabd15
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(productImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(storeNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        self.priceLabel.text = nil
        self.storeNameLabel.text = nil
        self.productNameLabel.text = nil
        
    }

    
    override func setConstraints() {
        
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(productImage.snp.bottom).inset(10)
            make.size.equalTo(40)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(1)
            make.horizontalEdges.equalToSuperview()
            make.height.lessThanOrEqualTo(36)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    
}

