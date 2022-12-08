//
//  PokemonTypeAPIModel.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import Foundation

struct PokemonTypeAPIModel: Decodable {
    let count: Int
    let next: Int?
    let previous: Int?
    let results: [TypeResults]
    
    struct TypeResults: Decodable {
        let name: String
        let url: String
    }
}
