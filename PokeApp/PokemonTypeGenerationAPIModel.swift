//
//  PokemonTypeAPIModel.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import Foundation

struct PokemonTypeGenerationAPIModel: Decodable {
    let count: Int
    let next: Int?
    let previous: Int?
    let results: [TypeGenerationResults]
    
    struct TypeGenerationResults: Decodable {
        let name: String
        let url: String
    }
}
