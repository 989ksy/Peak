//
//  ProductCollectionViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//

import UIKit
import SnapKit

class ProductCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    let productImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let productNameLabel = {
        let label = UILabel()
        label.text = "스토어 이름"
        label.textColor = .black
        label.font = ConstantFont.reg13
        label.numberOfLines = 0
        return label
    }()
    
    let priceNameLaebel = {
        let label = UILabel()
        label.text = "######원"
        label.textColor = .black
        label.font = ConstantFont.extrabd13
        return label
    }()
    
    override func configureView() {
        
        contentView.addSubview(productImage)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceNameLaebel)
            
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.image = nil
        productNameLabel.text = nil
        priceNameLaebel.text = nil
        
    }
    
    override func setConstraints() {
        
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(11)
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
        priceNameLaebel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(6)
            make.height.equalTo(17)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
    }
    
}
