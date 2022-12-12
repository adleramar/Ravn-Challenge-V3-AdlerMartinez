//
//  PokemonCell.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import UIKit
import SwiftyGif

class PokemonCell: UITableViewCell, SwiftyGifDelegate {

    @IBOutlet weak var greyBackgroundView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonTypeImageViewLeft: UIImageView!
    @IBOutlet weak var pokemonTypeImageViewRight: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonImageView.delegate = self
    }

    func setupCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.key?.capitalized ?? ""
        pokemonNumberLabel.text = pokemon.stringId ?? ""
        self.setupPokemonSprite(urlString: pokemon.sprite ?? "")
        self.setupImageBy(type: pokemon.types?.first ?? "", imageView: pokemonTypeImageViewLeft)
        self.setupImageBy(type: pokemon.types?.last ?? "", imageView: pokemonTypeImageViewRight)
    }
    
    private func setupPokemonSprite(urlString: String) {
        // You can also set it with an URL pointing to your gif
        let url = URL(string: urlString)!
        pokemonImageView.setGifFromURL(url)
    }
    
    func setupImageBy(type: String, imageView: UIImageView) {
        switch type {
        case "normal":
            imageView.image = UIImage(named: "normal-type")
        case "fighting":
            imageView.image = UIImage(named: "fighting-type")
        case "flying":
            imageView.image = UIImage(named: "flying-type")
        case "poison":
            imageView.image = UIImage(named: "poison-type")
        case "ground":
            imageView.image = UIImage(named: "ground-type")
        case "rock":
            imageView.image = UIImage(named: "rock-type")
        case "bug":
            imageView.image = UIImage(named: "bug-type")
        case "ghost":
            imageView.image = UIImage(named: "ghost-type")
        case "steel":
            imageView.image = UIImage(named: "steel-type")
        case "fire":
            imageView.image = UIImage(named: "fire-type")
        case "water":
            imageView.image = UIImage(named: "water-type")
        case "grass":
            imageView.image = UIImage(named: "grass-type")
        case "electric":
            imageView.image = UIImage(named: "electric-type")
        case "psychic":
            imageView.image = UIImage(named: "psychic-type")
        case "ice":
            imageView.image = UIImage(named: "ice-type")
        case "dragon":
            imageView.image = UIImage(named: "dragon-type")
        case "dark":
            imageView.image = UIImage(named: "dark-type")
        case "fairy":
            imageView.image = UIImage(named: "fairy-type")
        default:
            imageView.image = UIImage(named: "pokeball")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}
