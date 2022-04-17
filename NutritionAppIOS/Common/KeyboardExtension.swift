//
//  KeyboardExtension.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.04.2021.
//

// Put this piece of code anywhere you like
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
