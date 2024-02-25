//
//  SearchbarCustom.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/25/23.
//

import UIKit

class SearchbarCustom : UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton() {
        searchBarStyle = .minimal
        showsCancelButton = true
        searchTextField.backgroundColor = .lightGray
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 4
        searchTextField.layer.borderColor =  UIColor.lightGray.cgColor
        searchTextField.font = ConstantFont.bd15
        searchTextField.backgroundColor = .white
        searchTextField.leftView?.tintColor = UIColor.lightGray
        searchTextField.borderStyle = .none
        searchTextField.textColor = .black
        tintColor = ConstantColor.Green
        
        
    }
}
