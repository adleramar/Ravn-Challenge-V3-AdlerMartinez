//
//  PokeAPIService.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import Foundation
import Combine

class PokeAPIService {
    
    var url: URLSession!
    private lazy var jsonDecoder = JSONDecoder()
    var sessionConfig: URLSessionConfiguration!
    
    init() {
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        url = URLSession(configuration: sessionConfig)
    }
    
    // MARK: - API methods
    // empty string will make the URl return all generations of pokémon
    func getPokemonGenerations() -> AnyPublisher<PokemonTypeGenerationAPIModel, NetworkError> {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/generation/")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return url.dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.badResponse
                }
                return response.data
            }
            .decode(type: PokemonTypeGenerationAPIModel.self, decoder: jsonDecoder)
            .mapError { _ in
                return .badInfo
            }
            .eraseToAnyPublisher()
    } // getPokemonGenerations()
    
    // specified number of generation to get from URL
    func getPokemongeneration(generationName: String) -> AnyPublisher<GenerationDetailsAPIModel, NetworkError> {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/generation/\(generationName)")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return url.dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.badResponse
                }
                return response.data
            }
            .decode(type: GenerationDetailsAPIModel.self, decoder: jsonDecoder)
            .mapError { _ in
                return .badInfo
            }
            .eraseToAnyPublisher()
    } // getPokemongeneration()
    
    func getPokemonTypes() -> AnyPublisher<PokemonTypeGenerationAPIModel, NetworkError> {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/type")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return url.dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.badResponse
                }
                return response.data
            }
            .decode(type: PokemonTypeGenerationAPIModel.self, decoder: jsonDecoder)
            .mapError { _ in
                return .badInfo
            }
            .eraseToAnyPublisher()
    } // end getPokemonTypes()
}
