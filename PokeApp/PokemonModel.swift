//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation
import PokemonAPI

typealias PokemonData = GetAllPokemonQuery.Data.GetAllPokemon

struct Pokemon: Decodable {
    var pokemonList: [PokemonInfo]
    
    init(_ pokemonList: PokemonData?) {
        self.pokemonList = pokemonList.map({ pokemon -> Pokemon.PokemonInfo in
            PokemonInfo(from: pokemon)
        }) ?? []
    }
    
    struct PokemonInfo: Identifiable, Decodable {
        var num: Int
        var color: String
        var baseSpecies: String
        var key: GraphQLEnum<PokemonEnum>
        var sprite: String
        var types: [Type_SelectionSet]
            .field("preevolutions", [Preevolution]?.self),
            .field("evolutions", [Evolution]?.self),
    }
}
