//
//  MainStoryboardInstance.swift
//  PokeApp
//
//  Created by Adler on 12/12/22.
//

import UIKit

protocol MainStoryboardInstance {
    static func instantiate() -> Self
}

extension MainStoryboardInstance where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
