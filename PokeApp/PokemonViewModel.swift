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
    var allPokemon: [Pokemon]
    var pokeAPIService: PokeAPIService
    var pokemonRepository: StoredPokemonRepository
    
    init() {
        allPokemon = []
        pokeAPIService = PokeAPIService()
        pokemonRepository = StoredPokemonRepository()
    }
    
    func fetchDataFromService() {
        if pokemonRepository.checkStoredPokemon() != nil {
            
        } else {
            ApolloNetworkHelper.shared.apolloClient.fetch(query: GetAllPokemonQuery()) { [weak self] result in
                switch result {
                case .success(let petitionResult):
                    guard let pokemon = petitionResult.data?.getAllPokemon else {
                        print("Error: \(String(describing: petitionResult.errors))")
                        return
                    }
    //                print("Success! Result: \(petitionResult)")
                    self?.pokeAPIService.getPokemonTypes() { data in
                        DispatchQueue.main.async {
                            if self?.pokemonRepository.storePokemonLocally(pokemon: self?.processPokemon(data: pokemon) ?? [], types: data?.results ?? []) == true {
                                
                            }
                        }
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
        }
    }
    
    func processPokemon(data: [PokemonData]) -> [PokemonInfoAPIModel] {
        return PokemonAPIModel(data).pokemonList
    }
}
