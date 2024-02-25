//
//  BaseView.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {

    }
    
    func setConstraints() {
        
    }
    
}


