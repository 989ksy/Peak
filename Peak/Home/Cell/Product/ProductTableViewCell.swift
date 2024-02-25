//
//  ProductTableViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//

import UIKit
import SnapKit
import Kingfisher

class ProductTableViewCell : BaseTableViewCell {
    
    static let identifier = "ProductTableViewCell"
    
    var mdList: Search = Search(total: 0, start: 0, display: 0, items: []) //이런 상품은 어떠신가요?
    
    let titleLabel = {
        let view = UILabel()
        view.font = ConstantFont.extrabd15
        view.textColor = .black
        view.text = "이런 상품은 어떠신가요?"
        return view
    }()
    
    let productCollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.showsHorizontalScrollIndicator = false
        view.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        return view
    }()
    
    
    let transitedButton = {
        let btn = UIButton()
        btn.setTitle("자세히 알아보기", for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.7
        btn.layer.borderColor = UIColor.systemGray2.cgColor
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = ConstantFont.bd13
        return btn
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing)
        
        layout.itemSize = CGSize(width: width / 3 , height: 190)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    override func configureView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(productCollectionView)
        contentView.addSubview(transitedButton)
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        networkForMD()
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(17)
        }
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(208)
            make.horizontalEdges.equalToSuperview()
        }
        transitedButton.snp.makeConstraints { make in
            make.top.equalTo(productCollectionView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(45)
        }
    }
    
    func networkForMD() {
        
        NetworkManager.shared.callRequest(query: "캠핑 랜턴", sort: "sim", page: 1, display: 10) { data in
            self.mdList = data
            self.productCollectionView.reloadData()
        } failure: {
            print("md : 네트워크 실패!")
        }
    }
    
}


extension ProductTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mdList.items.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let data = mdList.items[indexPath.item]
        
        //가격
        let value = Int(data.lprice)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: value) ?? data.lprice
        
        cell.priceNameLaebel.text = "\(result)원"
        
        //용품 이름
        let fixedTitle = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.productNameLabel.text = fixedTitle
        cell.productNameLabel.setLineSpacing(spacing: 1)
        
        //제품 이미지
        if let url = URL(string: data.image!) {
            cell.productImage.kf.setImage(with: url)
        }
        
        return cell
        
    }
    
    
    
    
    
    
}
