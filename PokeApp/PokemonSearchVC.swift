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

class PokemonSearchVC: UIViewController, UITableViewDelegate {
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
                    self?.pokemonTableView.refreshControl?.beginRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .loading:
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .error:
                    self?.pokemonTableView.refreshControl?.endRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                case .success:
                    self?.pokemonTableView.refreshControl?.endRefreshing()
                    self?.createSnapshot(generations: self?.viewModel.data ?? [1])
                default:
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
        dataSource = PokemonDataSource(tableView: pokemonTableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell in
            if item is Int {
                let loadingCell = tableView.dequeueReusableCell(withIdentifier: "loadingDataCell", for: indexPath) as! LoadingDataCell
                return loadingCell
            } else if let pokemonData = item as? Pokemon {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
                cell.setupCell(pokemon: pokemonData)
                return cell
            }
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "loadingDataCell", for: indexPath) as! LoadingDataCell
            loadingCell.loadingLabel.text = "No data"
            return loadingCell
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
//        snapshot.appendSections(generations)
//        for genSection in generations {
////            snapshot.appendItems(genSection.pokemon, toSection: genSection)
//            guard let pokemonByGen = genSection.pokemon?.allObjects as? [Pokemon] else {return}
//            snapshot.appendItems(pokemonByGen, toSection: genSection)
//        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GenHeaderView", owner: self, options: nil)?.first as! GenHeaderView
        guard let sections = viewModel.data as? [PokemonViewModel.PokemonByGenerations] else {return UIView()}
        headerView.genLabel.text = sections[section].generation.name ?? ""
        return headerView
    }
}

