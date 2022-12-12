//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation
import Apollo
import PokemonAPI
import Combine

class PokemonViewModel {
   var allPokemon: [Pokemon] = []
   var allGenerations: [Generation]  = []
   var data: [AnyHashable]  = [1]
   var pokeAPIService: PokeAPIService
   var pokemonRepository: StoredPokemonRepository
   @Published var getDataStatus: DataStatus!
   internal var subscriptions: Set<AnyCancellable>
   
   init() {
      pokeAPIService = PokeAPIService()
      pokemonRepository = StoredPokemonRepository()
      getDataStatus = .initialize
      subscriptions = Set<AnyCancellable>()
   }
   
   struct PokemonByGenerations: Hashable {
      let uuid = UUID()
      let generation: Generation
      let pokemon: [Pokemon]
   }
   
   func fetchDataFromService() {
      NetworkManager.isUnreachable { [weak self] _ in
         self?.getDataStatus = .noInternet
      }
      
      NetworkManager.isReachable { [weak self] _ in
         
         ApolloNetworkHelper.shared.apolloClient.fetch(query: GetAllPokemonQuery()) { result in
            self?.getDataStatus = .loadingPokemon
            
            switch result {
            case .success(let petitionResult):
               guard let pokemon = petitionResult.data?.getAllPokemon else {
                  print("Error: \(String(describing: petitionResult.errors))")
                  self?.getDataStatus = .error
                  return
               }
               
               if self?.saveLocallyAllPokemon(data: self?.processPokemon(data: pokemon) ?? []) == true {
                  self?.savePokemonDetailsLocally()
                  self?.getDataStatus = .success
               }
               
            case .failure(let error):
               print("Failure! Error: \(error)")
               self?.getDataStatus = .error
            }
         }
      }
   }
   
   func processPokemon(data: [PokemonData]) -> [PokemonInfoAPIModel] {
      return PokemonAPIModel(data).pokemonList
   }
   
   func saveLocallyAllPokemon(data: [PokemonInfoAPIModel]) -> Bool {
      return pokemonRepository.storePokemonLocally(pokemon: data)
   }
   
   func savePokemonDetailsLocally() {
      fetchGenerationsFromService()
      assignPokemonToGeneration()
      getPokemonByGenerationsFromStorage()
   }
   
   func saveGeneralGenerationInformationLocally(data: PokemonTypeGenerationAPIModel) {
      return pokemonRepository.storeGenerationsLocally(generations: data)
   }
   
   func fetchGenerationsFromService() {
//      NetworkManager.isReachable { [weak self] _ in
         pokeAPIService.getPokemonGenerations()
            .receive(on: DispatchQueue.main, options: .none)
            .sink(receiveCompletion: { res in
               switch res {
               case .finished:
                  self.getDataStatus = .processData
               case .failure(_):
                  break
               }
            }, receiveValue: { data in
               self.saveGeneralGenerationInformationLocally(data: data)
            })
            .store(in: &subscriptions)
//      }
      
      NetworkManager.isUnreachable { [weak self] _ in
         self?.getDataStatus = .noInternet
      }
   }
   
   func assignPokemonToGeneration() {
      let genNames = pokemonRepository.checkStoredGenerations()?.map{$0.name} ?? []
      
      for singleGen in genNames {
         pokeAPIService.getPokemongeneration(generationName: singleGen ?? "")
            .receive(on: DispatchQueue.main, options: .none)
            .sink(receiveCompletion: { [weak self] res in
               switch res {
               case .finished:
                  self?.getDataStatus = .loadingPokemonGenerations
               case .failure(_):
                  break
               }
            }, receiveValue: { [weak self] data in
               self?.pokemonRepository.addPokemonToGeneration(generationDetails: data)
            })
            .store(in: &subscriptions)
      }
   }
   
   func getPokemonByGenerationsFromStorage()  {
      data = []
      for gen in self.pokemonRepository.checkStoredGenerations()?.sorted(by: {$0.name ?? "" < $1.name ?? ""}) ?? [] {
         let listOfPokemon = PokemonByGenerations(generation: gen, pokemon: (gen.pokemon?.allObjects as! [Pokemon]).sorted(by: {$0.num < $1.num}))
         data.append(listOfPokemon)
      }
   }
}
