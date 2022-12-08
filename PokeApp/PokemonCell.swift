//
//  PokemonCell.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var greyBackgroundView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonTypeImageViewLeft: UIImageView!
    @IBOutlet weak var pokemonTypeImageViewRight: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
