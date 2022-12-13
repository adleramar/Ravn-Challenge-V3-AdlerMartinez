//
//  PokemonDetailsVC.swift
//  PokeApp
//
//  Created by Adler on 12/12/22.
//

import UIKit
import SwiftyGif

fileprivate typealias EvolutionSnapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>
fileprivate typealias EvolutionDataSource = UITableViewDiffableDataSource<Int, AnyHashable>

class PokemonDetailsVC: UIViewController, UITableViewDelegate, MainStoryboardInstance {
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var spriteSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pokemonEvolutionsTableView: UITableView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    
    
    var pokemon: Pokemon!
    private var evolutionDataSource: EvolutionDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonEvolutionsTableView.delegate = self
        pokemonEvolutionsTableView.register(UINib(nibName: "PokemonEvolutionCell", bundle: nil), forCellReuseIdentifier: "pokemonEvolutionCell")
        pokemonEvolutionsTableView.register(UINib(nibName: "LoadingDataCell", bundle: nil), forCellReuseIdentifier: "loadingDataCell")
        
        pokemonNameLabel.text = "\(pokemon.stringId ?? "") \(pokemon.key?.capitalized.replacingOccurrences(of: "-", with: " ") ?? "")"
        
        spriteSegmentedControl.setTitle("Sprite", forSegmentAt: 0)
        spriteSegmentedControl.setTitle("Shiny sprite", forSegmentAt: 1)
        
        setupPokemonSprite(urlString: pokemon.sprite ?? "")
        
        if pokemon.shinySprite == nil {
            spriteSegmentedControl.isEnabled = false
        }
        
        setupBackground(color: pokemon.pokemonColor)
        generationLabel.text = pokemon.generation?.name?.uppercased()
        
        configureDataSource()
        
        guard let evolutions = pokemon.evolution?.allObjects as? [Evolution] else {return}
        
        if evolutions.count > 0 {
            createSnapshot(evolutions: evolutions)
        } else {
            createSnapshot(evolutions: [1])
        }
    }
    
    @IBAction func selectSprite(_ sender: UISegmentedControl) {
        switch spriteSegmentedControl.selectedSegmentIndex {
        case 0:
            setupPokemonSprite(urlString: pokemon.sprite ?? "")
        default:
            setupPokemonSprite(urlString: pokemon.shinySprite ?? "")
        }
    }
    
    
    private func setupPokemonSprite(urlString: String) {
        // You can also set it with an URL pointing to your gif
        let url = URL(string: urlString)!
        spriteImageView.setGifFromURL(url)
    }
    
    private func setupBackground(color: Pokemon.PokemonColor) {
        switch color {
        case .black:
            self.view.backgroundColor = UIColor(named: "Black")
        case .blue:
            self.view.backgroundColor = UIColor(named: "Blue")
        case .brown:
            self.view.backgroundColor = UIColor(named: "Brown")
        case .gray:
            self.view.backgroundColor = UIColor(named: "Gray")
        case .green:
            self.view.backgroundColor = UIColor(named: "Green")
        case .purple:
            self.view.backgroundColor = UIColor(named: "Purple")
        case .red:
            self.view.backgroundColor = UIColor(named: "Red")
        case .white:
            self.view.backgroundColor = UIColor(named: "White")
        case .yellow:
            self.view.backgroundColor = UIColor(named: "Yellow")
        }
    }
    
    private func configureDataSource() {
        evolutionDataSource = EvolutionDataSource(tableView: pokemonEvolutionsTableView, cellProvider: { [weak self] (tableView, indexPath, item) -> UITableViewCell in
           if let pokemonData = item as? Evolution {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonEvolutionCell", for: indexPath) as! PokemonEvolutionCell
                cell.setupCell(pokemon: (self?.pokemon)!, evolution: pokemonData)
                return cell
            }
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "loadingDataCell", for: indexPath) as! LoadingDataCell
            loadingCell.loadingLabel.text = "This Pokemon has no evolutions"
            return loadingCell
        })
    }
    
    private func createSnapshot(evolutions: [AnyHashable]) {
        var snapshot = EvolutionSnapshot()
        
        
        snapshot.appendSections([1])
        snapshot.appendItems(evolutions)
        
        evolutionDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GenHeaderView", owner: self, options: nil)?.first as! GenHeaderView
        headerView.genLabel.text = "Evolutions"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
