//
//  EvolutionInfo.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Foundation

struct EvolutionAPIModel: Hashable, Decodable {
    var uuid = UUID()
    let num: Int
    let color: String
    let key: String
    let sprite: String
    let shinySprite: String?
    
    enum CodingKeys: CodingKey {
        case num
        case color
        case key
        case sprite
        case shinySprite
    }
    
    init(_ evolution: PokemonPreevolution?) {
        self.num = evolution?.num ?? 0
        self.color = evolution?.color ?? ""
        self.key = evolution?.key.rawValue ?? ""
        self.sprite = evolution?.sprite ?? ""
        self.shinySprite = evolution?.shinySprite ?? ""
    }
    
    init(_ evolution: PokemonEvolution?) {
        self.num = evolution?.num ?? 0
        self.color = evolution?.color ?? ""
        self.key = evolution?.key.rawValue ?? ""
        self.sprite = evolution?.sprite ?? ""
        self.shinySprite = evolution?.shinySprite ?? ""
    }
}
