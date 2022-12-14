//
//  DataStatus.swift
//  PokeApp
//
//  Created by Adler on 9/12/22.
//

import Foundation

enum DataStatus {
    case initialize
    case loadingPokemon
    case loadingPokemonTypes
    case processData
    case error
    case success
    case noInternet
}
