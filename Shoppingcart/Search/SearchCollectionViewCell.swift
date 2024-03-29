//
//  SearchCollectionViewCell.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//
//  <상품 검색> 컬렉션뷰셀 : 상품이미지, 가게명, 상품이름, 좋아요 버튼

import UIKit
import SnapKit
import RealmSwift


class SearchCollectionViewCell: BaseCollectionViewCell {
        
    let productImage = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let likeButton = {
        let view = UIButton()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let storeNameLabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    let productNameLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .white
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    let priceLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        return view
        
    }()
    
    override func configureView() {
        addSubview(productImage)
        addSubview(likeButton)
        addSubview(storeNameLabel)
        addSubview(productNameLabel)
        addSubview(priceLabel)

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
            make.top.equalTo(productNameLabel.snp.bottom).offset(1)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    
}
