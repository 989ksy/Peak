//
//  HotSearchTableViewCell.swift
//  Peak
//
//  Created by Seungyeon Kim on 1/5/24.
//

import UIKit
import SnapKit

class HotSearchTableViewCell: BaseTableViewCell {
    
    static let identifier = "HotSearchTableViewCell"
    
    let rankingLabel = {
        let label = UILabel()
        label.textColor = ConstantColor.Green
        label.font = ConstantFont.extrabd15
        return label
    }()
    
    let itemLabel = {
        let label = UILabel()
        label.text = "더미"
        label.font = ConstantFont.bd15
        return label
    }()
    
    override func configureView() {
        contentView.addSubview(rankingLabel)
        contentView.addSubview(itemLabel)
    }
    
    override func setConstraints() {
        rankingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(rankingLabel.snp.trailing).offset(15)
        }
    }
    
    
}
