//
//  ViewController.swift
//  PokeApp
//
//  Created by Adler on 3/12/22.
//

import UIKit

fileprivate typealias PokemonSnapshot = NSDiffableDataSourceSnapshot<Int, Pokemon>
fileprivate typealias PokemonDataSource = UITableViewDiffableDataSource<Int, Pokemon>

class PokemonSearchVC: UIViewController, UITableViewDelegate {
    // Outlets
    @IBOutlet weak var pokemonTableView: UITableView!
    // Variables
    var viewModel: PokemonViewModel!
    let searchController = UISearchController()
    private var dataSource: PokemonDataSource!
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
        pokemonTableView.separatorStyle = .none
        pokemonTableView.register(UINib(nibName: "LoadingDataCell", bundle: nil), forCellReuseIdentifier: "loadingDataCell")
        pokemonTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
        viewModel = PokemonViewModel()
        viewModel.fetchDataFromService()
        configureDataSource()
        createSnapshot(generations: self.viewModel.allPokemon)
    }

    private func configureDataSource() {
        dataSource = PokemonDataSource(tableView: pokemonTableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
            cell.setupCell(pokemon: item)
            return cell
        })
    }
    
    private func createSnapshot(generations: [Pokemon]) {
        var snapshot = PokemonSnapshot()
        
        snapshot.appendSections([1])
        snapshot.appendItems(generations)
        dataSource?.apply(snapshot)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

