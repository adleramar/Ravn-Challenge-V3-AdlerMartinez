//
//  StoredPokemonRepository.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import UIKit
import CoreData

class StoredPokemonRepository {
    
    private var managedContext: NSManagedObjectContext!
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Repository Methods
    
    func checkStoredGenerations() -> [Generation]? {
        let fetchRequest = NSFetchRequest<Generation>(entityName: "Generation")
        
        do {
            let gens = try managedContext.fetch(fetchRequest)
            return gens
        } catch {
            return nil
        }
    } // end checkStoredPokemon()
    
    func storeGenerationsLocally(generations: PokemonTypeGenerationAPIModel) {
        for gen in generations.results {
            let g = fetchSingleGeneration(byName: gen.name)
            
            if g == nil {
                let generation = Generation(context: managedContext)
                
                generation.name = gen.name
                generation.urlString = gen.url
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addPokemonToGeneration(generationDetails: GenerationDetailsAPIModel) {
        guard let generation = fetchSingleGeneration(byName: generationDetails.name) else {return}
        
        for pokemon in generationDetails.pokemon_species {
            if let foundPokemon = fetchSinglePokemon(byName: pokemon.name) {
                generation.addToPokemon(foundPokemon)
            }
        }
        
        do {
            try managedContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchSinglePokemon(byName: String) -> Pokemon? {
        let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
        let predicate = NSPredicate(format: "key == %@", byName)
        
        fetchRequest.predicate = predicate
        
        do {
            let pokemon = try managedContext.fetch(fetchRequest)
            return pokemon.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchSingleGeneration(byName: String) -> Generation? {
        let fetchRequest = NSFetchRequest<Generation>(entityName: "Generation")
        let predicate = NSPredicate(format: "name == %@", byName)
        
        fetchRequest.predicate = predicate
        
        do {
            let generation = try managedContext.fetch(fetchRequest)
            return generation.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Method to check if Pokemon are already stored locally
    /// - Parameters: none
    /// - Returns: [Pokemon]?
    func checkStoredPokemon() -> [Pokemon]? {
        let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
        let sort = NSSortDescriptor(key: "num", ascending: true)
        
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let pokemon = try managedContext.fetch(fetchRequest)
            return pokemon
        } catch {
            return nil
        }
    } // end checkStoredPokemon()
    
    
    func storePokemonLocally(pokemon: [PokemonInfoAPIModel]) -> Bool {
        for singlePokemon in pokemon {
            let p = fetchSinglePokemon(byName: singlePokemon.key)
            
            if p == nil {
                let localPokemon = Pokemon(context: managedContext)
                
                localPokemon.num = Int16(singlePokemon.num)
                localPokemon.stringId = "#\(singlePokemon.num)"
                localPokemon.color = singlePokemon.color
                localPokemon.baseSpecies = singlePokemon.baseSpecies
                localPokemon.key = singlePokemon.key
                localPokemon.sprite = singlePokemon.sprite
                localPokemon.shinySprite = singlePokemon.shinySprite
                localPokemon.types = singlePokemon.types.map({$0.name.lowercased()})
                
                if let preevolutions = singlePokemon.preevolutions {
                    self.storePokemonPreevolutions(pokemon: localPokemon, preevolutions: preevolutions)
                }
                if let evolutions = singlePokemon.evolutions {
                    self.storePokemonEvolutions(pokemon: localPokemon, evolutions: evolutions)
                }
                
            }
        }
        do {
            try managedContext.save()
            return true
        } catch {
            //                fatalError(error.localizedDescription)
            return false
        }
    } // end storePokemonLocally()
    
    /// Method to add the pokemon evolution data to a pokemon
    /// - Parameters:
    ///     - pokemon: core data pokemon object
    ///     - evolutions: array of pokemon evolution details
    func storePokemonEvolutions(pokemon: Pokemon, evolutions: [EvolutionAPIModel]) {
        for evolution in evolutions {
            let localPokemonEvolution = Evolution(context: managedContext)
            
            localPokemonEvolution.num = Int16(evolution.num)
            localPokemonEvolution.color = evolution.color
            localPokemonEvolution.key = evolution.key
            localPokemonEvolution.sprite = evolution.sprite
            localPokemonEvolution.stringId = "#\(evolution.num)"
            localPokemonEvolution.shinySprite = evolution.shinySprite
            
            pokemon.addToEvolution(localPokemonEvolution)
        }
    } // end storePokemonEvolutions()
    
    /// Method to add the pokemon preevolution data to a pokemon
    /// - Parameters:
    ///     - pokemon: core data pokemon object
    ///     - preevolutions: array of pokemon preevolution details
    func storePokemonPreevolutions(pokemon: Pokemon, preevolutions: [EvolutionAPIModel]) {
        for preevolution in preevolutions {
            let localPokemonPreEvolution = PreEvolution(context: managedContext)
            
            localPokemonPreEvolution.num = Int16(preevolution.num)
            localPokemonPreEvolution.color = preevolution.color
            localPokemonPreEvolution.key = preevolution.key
            localPokemonPreEvolution.sprite = preevolution.sprite
            localPokemonPreEvolution.shinySprite = preevolution.shinySprite
            
            pokemon.addToPreevolution(localPokemonPreEvolution)
        }
    } // end storePokemonPreevolutions()
}
