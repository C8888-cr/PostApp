//
//  HttpServiceProtocol.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation


protocol HttpServiceProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class DefaultHttpService: HttpServiceProtocol {
  
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
 
      
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
