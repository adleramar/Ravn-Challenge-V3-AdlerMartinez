//
//  PokemonColor.swift
//  PokeApp
//
//  Created by Adler on 12/12/22.
//

import Foundation
import CoreData

extension Pokemon {
    enum PokemonColor: String, CaseIterable {
        case black = "Black"
        case blue = "Blue"
        case brown = "Brown"
        case gray = "Gray"
        case green = "Green"
        case purple = "Purple"
        case red = "Red"
        case white = "White"
        case yellow = "Yellow"
    }
    
    var pokemonColor: PokemonColor {
        set {
            color = newValue.rawValue
        }
        
        get {
            PokemonColor.allCases.filter{$0.rawValue == color}.first ?? .white
        }
    }
}
