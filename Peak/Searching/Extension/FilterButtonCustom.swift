//
//  SearchViewUIButton.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit

class FilterButtonCustom: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton() {
        titleLabel?.font = ConstantFont.bd14
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 6
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 1
    }
    
    
}
