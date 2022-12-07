//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation
import Apollo
import PokemonAPI

class PokemonViewModel {
    var allPokemon: [PokemonDetails]
    
    init() {
        allPokemon = []
    }
    
    func fetchDataFromService() {
        ApolloNetworkHelper.shared.apolloClient.fetch(query: GetAllPokemonQuery()) { [weak self] result in
            switch result {
            case .success(let petitionResult):
                guard let pokemon = petitionResult.data?.getAllPokemon else {
                    print("Error: \(String(describing: petitionResult.errors))")
                    return
                }
//                print("Success! Result: \(petitionResult)")
                self?.allPokemon = self?.processPokemon(data: pokemon) ?? []
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
    
    func processPokemon(data: [PokemonData]) -> [PokemonDetails] {
        return Pokemon(data).pokemonList
    }
}
