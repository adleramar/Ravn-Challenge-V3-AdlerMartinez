//
//  ApolloNetworkHelper.swift
//  PokeApp
//
//  Created by Adler on 6/12/22.
//

import Apollo
import Foundation

final class ApolloNetworkHelper {
    static let shared = ApolloNetworkHelper()
    let urlString = "https://graphqlpokemon.favware.tech/v7"
    private(set) lazy var apolloClient = ApolloClient(url: URL(string: urlString)!)
}


