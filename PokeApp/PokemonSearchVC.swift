//
//  ViewController.swift
//  PokeApp
//
//  Created by Adler on 3/12/22.
//

import UIKit
import Combine

fileprivate typealias PokemonSnapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>
fileprivate typealias PokemonDataSource = UITableViewDiffableDataSource<AnyHashable, AnyHashable>

class PokemonSearchVC: UIViewController, UITableViewDelegate, PokemonDelegate {
    // Outlets
    @IBOutlet weak var pokemonTableView: UITableView!
    // Variables
    var viewModel: PokemonViewModel!
    let searchController = UISearchController()
    private var dataSource: PokemonDataSource!
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémon List"
        navigationItem.searchController = searchController
        pokemonTableView.delegate = self
        pokemonTableView.separatorStyle = .none
        pokemonTableView.refreshControl = refresher
        pokemonTableView.register(UINib(nibName: "LoadingDataCell", bundle: nil), forCellReuseIdentifier: "loadingDataCell")
        pokemonTableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
        
        configureDataSource()
        initializeViewModel()
    }
    
    func initializeViewModel() {
        viewModel = PokemonViewModel()
        
        viewModel?.$getDataStatus
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] value in
                switch value {
                case .initialize:
//                  self?.navigationItem.searchController?.searchBar.isHidden = true
                    self?.pokemonTableView.refreshControl?.beginRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .loadingPokemon:
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .loadingPokemonTypes:
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .processData:
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .success:
                    //                    self?.navigationItem.searchController?.searchBar.isHidden = false
                    self?.pokemonTableView.refreshControl?.endRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .error:
                    //                    self?.navigationItem.searchController?.searchBar.isHidden = false
                    self?.pokemonTableView.refreshControl?.endRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .noInternet:
                    self?.pokemonTableView.refreshControl?.endRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                    self?.noInternetToast()
                case .none:
                    break
                }
            })
            .store(in: &subscriptions)
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    @objc func loadData() {
        viewModel.fetchDataFromService()
    }
    
    private func configureDataSource() {
        dataSource = PokemonDataSource(tableView: pokemonTableView, cellProvider: { [weak self] (tableView, indexPath, item) -> UITableViewCell in
            if item is Int  {
                let loadingCell = tableView.dequeueReusableCell(withIdentifier: "loadingDataCell", for: indexPath) as! LoadingDataCell
                if self?.viewModel.getDataStatus == .error || self?.viewModel.getDataStatus == .noInternet {
                    loadingCell.loadingLabel.text = "No data"
                } else {
                    loadingCell.loadingLabel.text = "Loading..."
                }
                return loadingCell
            } else if let pokemonData = item as? Pokemon {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
                cell.setupCell(pokemon: pokemonData)
                cell.delegate = self
                return cell
            }
            return UITableViewCell()
        })
    }
    
    private func createSnapshot(generations: [AnyHashable]) {
        var snapshot = PokemonSnapshot()
        
        if generations.first is Int {
            snapshot.appendSections([1])
            snapshot.appendItems(generations)
        } else {
            guard let sections = generations as? [PokemonViewModel.PokemonByGenerations] else {return}
            
            snapshot.appendSections(sections)
            
            for genSection in sections {
                snapshot.appendItems(genSection.pokemon, toSection: genSection)
            }
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GenHeaderView", owner: self, options: nil)?.first as! GenHeaderView
        guard let sections = viewModel.data as? [PokemonViewModel.PokemonByGenerations] else {return UIView()}
        let genName = sections[section].generation.name?.replacingOccurrences(of: "-", with: " ").uppercased()
        headerView.genLabel.text = genName
        return headerView
    }
    
    func presentPokemonDetails(pokemon: Pokemon) {
        let detailsVC = PokemonDetailsVC.instantiate()
        detailsVC.pokemon = pokemon
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

