//
//  GetPostsByUserIdUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation

class GetPostsByUserIdUseCase {

    static let shared = GetPostsByUserIdUseCase()
    private let postRepository = PostRepository.shared
 
    private init() {}
    
    func execute (userId: Int) async throws -> [Post] {
        try await postRepository.getPostsByUserId(userId: userId)
    }
    }
        
     
