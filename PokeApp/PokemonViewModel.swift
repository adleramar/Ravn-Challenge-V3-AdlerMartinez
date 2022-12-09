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
    var allGenerations: [Generation]
    var pokeAPIService: PokeAPIService
    var pokemonRepository: StoredPokemonRepository
    
    init() {
        allPokemon = []
        allGenerations = []
        pokeAPIService = PokeAPIService()
        pokemonRepository = StoredPokemonRepository()
    }
    
    func fetchDataFromService() {
        if pokemonRepository.checkStoredPokemon()?.count ?? 0 > 0 {
            self.allPokemon = pokemonRepository.checkStoredPokemon() ?? []
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
                                self?.fetchGenerationsFromService()
                                self?.allGenerations = self?.pokemonRepository.checkStoredGenerations() ?? []
                                self?.allPokemon = self?.pokemonRepository.checkStoredPokemon() ?? []
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
    
    func fetchGenerationsFromService() {
        if pokemonRepository.checkStoredGenerations() == nil {
            pokeAPIService.getPokemonGenerations() { [weak self] data in
                DispatchQueue.main.async {
                    if let genData = data {
                        if self?.pokemonRepository.storeGenerationsLocally(generations: genData) == true {
                            self?.assignPokemonToGeneration()
                        }
                    }
                }
            }
        }
    }
    
    func assignPokemonToGeneration() {
        let genNames = pokemonRepository.checkStoredGenerations()?.map{$0.name} ?? []
        
        for singleGen in genNames {
            pokeAPIService.getPokemongeneration(generationName: singleGen ?? "") { [weak self] data in
                DispatchQueue.main.async {
                    if let genDetails = data {
                        self?.pokemonRepository.addPokemonToGeneration(generationDetails: genDetails)
                    }
                }
            }
        }
    }
}
