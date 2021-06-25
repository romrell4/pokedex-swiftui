//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import Foundation
import Combine

protocol PokemonRepository {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}

enum Endpoint {
    case loadPokemonRefs
    case loadPokemon(url: String)
    
    var url: URL {
        let url: String
        switch self {
        case .loadPokemonRefs:
            url = "https://pokeapi.co/api/v2/pokemon?limit=10000"
        case .loadPokemon(let pokemonUrl):
            url = pokemonUrl
        }
        return URL(string: url)!
    }
}

private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

struct PokemonRepositoryImpl: PokemonRepository {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: endpoint.url)
        print(request)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> T in
                print(String(data: result.data, encoding: .utf8)!)
                return try decoder.decode(T.self, from: result.data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct TestPokemonRepository: PokemonRepository {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        switch endpoint {
        case .loadPokemonRefs: return Result.Publisher(load("pokemon-refs.json")).eraseToAnyPublisher()
        case .loadPokemon: return Result.Publisher(load("pokemon.json")).eraseToAnyPublisher()
        }
    }
    
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

}
