//
//  SectionHeader.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/27/23.
//

import UIKit
import SnapKit

class SectionHeader: UICollectionReusableView {
    
    let titleLabel = {
        let view = UILabel()
        view.font = ConstantFont.bd15
        view.textColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
    }
    
}
