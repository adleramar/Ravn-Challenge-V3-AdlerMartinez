//
//  ViewController.swift
//  PokeApp
//
//  Created by Adler on 3/12/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: PokemonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PokemonViewModel()
        viewModel.fetchDataFromService()
    }


}

