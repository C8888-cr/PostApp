//
//  GetPostsByUserIdUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation

class GetPostsByUserIdUseCase {

    private let postRepository: PostRepositoryProtocol
 
    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    func execute (userId: Int) async throws -> [Post] {
        return try await postRepository.getPostsByUserId(userId)
    }
    }
        
     
