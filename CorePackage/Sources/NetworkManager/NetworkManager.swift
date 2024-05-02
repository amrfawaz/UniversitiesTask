//
//  NetworkManager.swift
//  
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol Request {
    var urlRequest: URLRequest? { get }
    var parametrs: Any? { get }
}

protocol Service {
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}



public final class NetworkManager: Service {
    public static let shared = NetworkManager()
    
    private init() {}
    
    public func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
