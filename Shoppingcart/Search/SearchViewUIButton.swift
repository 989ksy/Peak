//
//  SearchViewUIButton.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/11.
//

import UIKit

class SearchViewUIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton() {
        titleLabel?.font = .systemFont(ofSize: 14)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 6
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    
}
