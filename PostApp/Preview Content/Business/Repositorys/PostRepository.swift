//
//  PostRepository.swift
//  PostApp
//
//  Created by Christiane Roth on 08.08.25.
//

import Foundation
import SwiftUI

//TODO: find out network error

class PostRepository: PostRepositoryProtocol {

    static let shared = PostRepository()
    private init() {}
    
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    let httpClient = HTTPClient.shared
  
    func getAllPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw HTTPError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidURL
        }
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
        } catch {
            throw NetworkError.invalidURL
        }
    }
    
    func getPostsByUserId(_ userId: Int) async throws -> [Post] {
            guard let url = URL(string: "\(baseURL)/posts?userId=\(userId)") else {
                throw NetworkError.invalidURL
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidURL
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                return posts
            } catch {
                // 2. Korrekten Fehler werfen
                throw NetworkError.invalidURL
            }
        }
    
    func getPostById(_id id: Int) async throws -> Post {
       
                guard let url = URL(string: "\(baseURL)/posts?Id=\(id)") else {
                    throw NetworkError.invalidURL
                }
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidURL
                }
                do {
                    let posts = try JSONDecoder().decode(Post.self, from: data)
                    return posts
                } catch {
                  
                    throw NetworkError.invalidURL
                }
            }
    
    func createPost(post: Post) async throws -> Post {
           guard let url = URL(string: "\(baseURL)/posts") else {
               throw NetworkError.invalidURL
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               request.httpBody = try JSONEncoder().encode(post)
           } catch {
               throw NetworkError.noData
           }
           
           let (data, response) = try await URLSession.shared.data(for: request)
           
           guard let httpResponse = response as? HTTPURLResponse,
                 httpResponse.statusCode == 201 else {
               throw NetworkError.noData
           }
           
           do {
               let createdPost = try JSONDecoder().decode(Post.self, from: data)
               return createdPost
           } catch {
               throw NetworkError.noData
           }
       }
    func updatePost(post: Post) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/\(String(describing: post.id))") else {
                throw NetworkError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONEncoder().encode(post)
            } catch {
                throw NetworkError.noData
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.invalidURL
            }
            
            do {
                let updatedPost = try JSONDecoder().decode(Post.self, from: data)
                return updatedPost
            } catch {
                throw NetworkError.invalidURL
            }
        }
    
    
 

 /*
    
    private let httpService: HttpServiceProtocol
    init(httpService: HttpServiceProtocol = DefaultHttpService()) {
           self.httpService = httpService
       }
    
    
    func getAllPosts() async -> ([Post]) async throws -> Void {
        let endpoint = "\(baseURL)/posts"
        guard let url = URL(string: endpoint) else {
            fatalError("Invalid URL: \(endpoint)")
        }
        let (data, response) = try await URLSession.shared.data(from: url)
    }
    
   func getAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts")
                else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
//Datenabfrage starten
        URLSession.shared.dataTask(with: url)
        { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
// Überprüfen ob die Antwort gültig ist
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
// Daten in das gewünschte Format decodieren
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    */
    /*
     
     
            private let baseURL = "https://jsonplaceholder.typicode.com/posts"
            
            func execute(completion: @escaping (Result<[Post], Error>) -> Void) {
                guard let url = URL(string: baseURL) else {
                    print("Couldn't create URL")
                    completion(.failure(NetworkError.invalidURL))
                    return
                }
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        completion(.success(posts))
                    } catch {
                        completion(.failure(error))
                    }
                }.resume()
            }
        }


     */
    
    
    func getPostsByUserId(userId: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts?userId=\(userId)")
            else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url)
            { data, response, error in
                if let error = error {
                    completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func getPostById(id: Int, completion: @escaping (Result<Post?, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            do {
                let createdPost = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(createdPost))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
func updatePost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        //→ Sendet einen PUT-Request mit dem post-Objekt an /posts/{post.id}.
    guard let postId = post.id else {
        completion(.failure(NSError(domain: "Missing ID", code: 0, userInfo: nil)))
        return
    }
    if postId <= 0 {
        completion(.failure(NSError(domain: "Invalid ID", code: 0, userInfo: nil)))
        return
    }
    
    
    guard let url = URL(string: "\(baseURL)/posts/\(postId)") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(post)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
            }
          guard let data = data else {
                    completion(.failure(NSError(domain: "No data returned", code: 0, userInfo: nil)))
                    return
                }
                do {
                    let updatedPost = try JSONDecoder().decode(Post.self, from: data)
                    completion(.success(updatedPost))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    } catch {
        completion(.failure(error))
        return
        }
    }
}
