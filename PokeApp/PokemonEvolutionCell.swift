//
//  PokemonEvolutionCell.swift
//  PokeApp
//
//  Created by Adler on 12/12/22.
//

import UIKit
import SwiftyGif

class PokemonEvolutionCell: UITableViewCell {

    @IBOutlet weak var currentPokemonContainerView: UIView!
    @IBOutlet weak var currentPokemonNameLabel: UILabel!
    @IBOutlet weak var currentPokemonImageView: UIImageView!
    @IBOutlet weak var currentPokemonNumLabel: UILabel!
    
    @IBOutlet weak var evolutionContainerView: UIView!
    @IBOutlet weak var evolutionPokemonNameLabel: UILabel!
    @IBOutlet weak var evolutionNumLabel: UILabel!
    @IBOutlet weak var evolutionSpriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(pokemon: Pokemon, evolution: Evolution) {
        setupPokemonSprite(urlString: pokemon.sprite ?? "", imageView: currentPokemonImageView)
        currentPokemonNameLabel.text = pokemon.key?.capitalized ?? ""
        currentPokemonNumLabel.text = pokemon.stringId ?? ""
        currentPokemonContainerView.asCircle()
        currentPokemonContainerView.layer.backgroundColor = UIColor(named: "Gray")?.cgColor
        //Evolution
        setupPokemonSprite(urlString: evolution.sprite ?? "", imageView: evolutionSpriteImageView)
        evolutionPokemonNameLabel.text = evolution.key?.capitalized ?? ""
        evolutionNumLabel.text = evolution.stringId ?? ""
        evolutionContainerView.asCircle()
        evolutionContainerView.layer.backgroundColor = UIColor(named: "Gray")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    private func setupPokemonSprite(urlString: String, imageView: UIImageView) {
        // You can also set it with an URL pointing to your gif
        let url = URL(string: urlString)!
        imageView.setGifFromURL(url)
    }
}
