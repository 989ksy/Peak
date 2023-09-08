//
//  BaseViewController.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/07.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = .black
        
    }
    
    func setConstraints() {
        
    }
    
}
