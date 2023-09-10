//
//  SearchCollectionViewCell.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//  <상품 검색> 컬렉션뷰셀 : 상품이미지, 가게명, 상품이름, 좋아요 버튼

import UIKit
import SnapKit
import RealmSwift


class SearchCollectionViewCell: BaseCollectionViewCell {
    
    var data : Item?
    var shoppingData : Shopping?
    let repository = ShoppingRepository()
    
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
        
        repository.getFileURL()
//        repository.fetch()

        likeButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

    }
    
    
    @objc func favoriteButtonTapped() {
        
        //버튼을 누를 때마다 데이터가 저장중...................
        
        guard let data = data else {return}
        
    // 좋아요 버튼 클릭 시 데이터 저장 (realm create)
        let task = Shopping(productImage: data.image, productName: data.title, storeName: data.mallName, price: data.lprice, webLink: data.link, favorite: data.like, date: Date(), productId: data.productID)
        
        repository.createItem(task)
        
    //좋아요 버튼 상태
        var favoriteState = data.like //기본설정: Bool, false
        print("====1==초기설정값:\(favoriteState)")
        
        favoriteState.toggle()

        if favoriteState == true {
            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
            print("====현재상태:\(favoriteState), 좋아요 오케이!")
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            print("====현재상태:\(favoriteState) 좋아요 해제!")
        }
        
//        repository.updateItem(id: , like: <#T##Bool#>)

        
//        var favoriteState = data.favorite
        
//        if data.favorite == true {
//            favoriteState = false
//        } else {
//            favoriteState = true
//        }
//        print(favoriteState)
//
//        if favoriteState == true {
//            likeButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
//            print(favoriteState, "좋아요 오케이~")
//        } else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//            print(favoriteState, "좋아요 해제!")
//        }
        
//        print(data)
        
//        repository.updateItem(id: data._id, like: data.favorite)
//        print(data.favorite, favoriteState)

        
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
