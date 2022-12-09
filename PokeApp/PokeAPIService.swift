//
//  PokeAPIService.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import Foundation

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
    func getPokemonGenerations(completion: @escaping (_ Types: PokemonTypeGenerationAPIModel?) -> ()) {

        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/generation/")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = url.dataTask(with: request) { [weak self] (data, response, error) in
            if error != nil {
                completion(nil)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    if statusCode == 200 {
                        let _data = data ?? Data()
                        do {
                            if let response = try self?.jsonDecoder.decode(PokemonTypeGenerationAPIModel.self, from: _data) {
                                completion(response)
                            } else {
                                completion(nil)
                            }
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }// end getPokemonGenerations()
    
    // specified number of generation to get from URL
    func getPokemongeneration(generationName: String, completion: @escaping (_ Types: GenerationDetailsAPIModel?) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/generation/\(generationName)")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = url.dataTask(with: request) { [weak self] (data, response, error) in
            if error != nil {
                completion(nil)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    if statusCode == 200 {
                        let _data = data ?? Data()
                        do {
                            if let response = try self?.jsonDecoder.decode(GenerationDetailsAPIModel.self, from: _data) {
                                completion(response)
                            } else {
                                completion(nil)
                            }
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }// end getPokemongeneration()
    
    func getPokemonTypes(completion: @escaping (_ Types: PokemonTypeGenerationAPIModel?) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/type")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = url.dataTask(with: request) { [weak self] (data, response, error) in
            if error != nil {
                completion(nil)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    if statusCode == 200 {
                        let _data = data ?? Data()
                        do {
                            if let response = try self?.jsonDecoder.decode(PokemonTypeGenerationAPIModel.self, from: _data) {
                                completion(response)
                            } else {
                                completion(nil)
                            }
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }// end getPokemonTypes()
}
