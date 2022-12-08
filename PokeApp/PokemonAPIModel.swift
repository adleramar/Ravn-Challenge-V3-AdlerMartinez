//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation
import PokemonAPI

typealias PokemonData = GetAllPokemonQuery.Data.GetAllPokemon
typealias PokemonPreevolution = GetAllPokemonQuery.Data.GetAllPokemon.Preevolution
typealias PokemonEvolution = GetAllPokemonQuery.Data.GetAllPokemon.Evolution

struct PokemonAPIModel: Decodable {
    var pokemonList: [PokemonInfoAPIModel]
    
    init(_ pokemonList: [PokemonData]?) {
        self.pokemonList = pokemonList?.map({ pokemon -> PokemonInfoAPIModel in
            PokemonInfoAPIModel(pokemon)
        }) ?? []
    }
}




