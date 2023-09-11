//
//  Extension+Keyboard.swift
//  Shoppingcart
//
//  Created by Seungyeon Kim on 2023/09/11.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedBackground() {
         let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapEvent.cancelsTouchesInView = false
         view.addGestureRecognizer(tapEvent)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
