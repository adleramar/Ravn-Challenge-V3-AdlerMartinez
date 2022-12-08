//
//  PokemonDetails.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation

struct PokemonInfoAPIModel: Hashable, Decodable {
    var uuid = UUID()
    let num: Int
    let color: String
    let baseSpecies: String
    let key: String
    let sprite: String
    let shinySprite: String?
    let types: [String]
    let preevolutions: [EvolutionAPIModel]?
    let evolutions: [EvolutionAPIModel]?
    
    enum CodingKeys: CodingKey {
        case num
        case color
        case baseSpecies
        case key
        case sprite
        case shinySprite
        case types
        case preevolutions
        case evolutions
    }
    
    init(_ pokemon: PokemonData?) {
        self.num = pokemon?.num ?? 0
        self.color = pokemon?.color ?? ""
        self.baseSpecies = pokemon?.baseSpecies ?? ""
        self.key = pokemon?.key.rawValue ?? ""
        self.sprite = pokemon?.sprite ?? ""
        self.shinySprite = pokemon?.shinySprite ?? ""
        self.types = pokemon?.types as? [String] ?? []
        self.preevolutions = pokemon?.preevolutions?.map({ preevolution -> EvolutionAPIModel in
            EvolutionAPIModel(preevolution)
        }) ?? []
        self.evolutions = pokemon?.evolutions?.map({ preevolution -> EvolutionAPIModel in
            EvolutionAPIModel(preevolution)
        }) ?? []
    }
}
