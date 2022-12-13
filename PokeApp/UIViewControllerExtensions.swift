//
//  UIViewControllerExtensions.swift
//  PokeApp
//
//  Created by Adler on 10/12/22.
//

import UIKit
import Toast

extension UIViewController {
    func noInternetToast() {
        var style = ToastStyle()
        style.backgroundColor = .red
        style.messageColor = .white
        self.view.makeToast("There's no internet connection", duration: 3.0, position: .center, style: style)
    }
    
    func dataError() {
        var style = ToastStyle()
        style.backgroundColor = .black
        style.messageColor = .white
        self.view.makeToast("An error has ocurred", duration: 3.0, position: .center, style: style)
    }
}
