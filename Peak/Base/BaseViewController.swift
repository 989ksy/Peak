//
//  BaseViewController.swift
//  Peak
//
//  Created by Seungyeon Kim on 12/23/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        
    }
    
    func setConstraints() {
        
    }
    
}

