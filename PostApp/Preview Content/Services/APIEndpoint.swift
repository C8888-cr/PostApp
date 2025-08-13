//
//  APIEndpoint.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation


enum APIEndpoint {
    
    case getAllPosts
    case getPost(id: Int)
    case createPost(post: Post)
    case updatePost(post: Post)
    case deletePost(id: Int)
    
    private var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    var url: URL? {
     
        
        switch self {
            
            case .getAllPosts:
                return URL(string: "\(baseURL)/posts")
            
            case .getPost(let id):
                return URL(string: "\(baseURL)/posts/\(id)")
            
            case .createPost:
                return URL(string: "\(baseURL)/posts")
            
            case .updatePost(let post):
                guard let id = post.id else
                {
                    return nil
                }
                return URL(string: "\(baseURL)/posts/\(id)")
            
            case .deletePost(let id):
                return URL(string: "\(baseURL)/posts/\(id)")
        }
    }
    
    var method: HTTPMethod {
    
        switch self {
            
            case .getAllPosts, .getPost:
                return .get
            
            case .createPost:
                return .post
            
            case .updatePost:
                return .put
            
            case .deletePost:
                return .delete
        }
    }
    
    var body: Data? {
       
        switch self {
        case .createPost(let post), .updatePost(let post):
            return try? JSONEncoder().encode(post)
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
     
        switch self {
        case .createPost, .updatePost:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
}
