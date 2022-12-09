//
//  GenerationDetailsAPIModel.swift
//  PokeApp
//
//  Created by Adler on 8/12/22.
//

import Foundation

struct GenerationDetailsAPIModel: Decodable {
    let abilities: [Content]
    let id: Int
    let main_region: Content
    let moves: [Content]
    let name: String
    let names: [LanguageDetails]
    let pokemon_species: [Content]
    let types: [Content]
    let version_groups: [Content]
    
    struct Content: Decodable {
        let name: String
        let url: String
    }
    
    struct LanguageDetails: Decodable {
        let language: Content
        let name: String
    }
}
