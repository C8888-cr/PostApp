//
//  CreatePostUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation

class CreatePostUseCase {
    private let postRepository = PostRepository.shared

    
    func execute(post: Post) async throws -> Post {
        return try await postRepository.createPost(post: post)
    }
}
