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
    
    func getPokemonTypes(completion: @escaping (_ Types: [PokemonTypeAPIModel]?) -> ()) {
        
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
                            if let response = try self?.jsonDecoder.decode([PokemonTypeAPIModel].self, from: _data) {
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
