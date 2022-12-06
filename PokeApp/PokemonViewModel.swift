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
    init() {
        
    }
    func fetchDataFromService() {
        ApolloNetworkHelper.shared.apolloClient.fetch(query: GetAllPokemonQuery(offset: nil)) { result in
            switch result {
            case .success(let petitionResult):
                print("Success! Result: \(petitionResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
    
    deinit {
        
    }
}
