//
//  ViewController.swift
//  PokeApp
//
//  Created by Adler on 3/12/22.
//

import UIKit

class PokemonSearchVC: UIViewController, UITableViewDelegate {
    // Outlets
    @IBOutlet weak var pokemonTableView: UITableView!
    // Variables
    var viewModel: PokemonViewModel!
    let searchController = UISearchController()
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémon List"
        navigationItem.searchController = searchController
        pokemonTableView.delegate = self
        pokemonTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
        viewModel = PokemonViewModel()
        viewModel.fetchDataFromService()
    }

    
}

