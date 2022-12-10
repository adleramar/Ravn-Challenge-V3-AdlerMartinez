//
//  NetworkError.swift
//  PokeApp
//
//  Created by Adler on 9/12/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badInfo
    case serverError
    case badResponse
    case notInternet
}
