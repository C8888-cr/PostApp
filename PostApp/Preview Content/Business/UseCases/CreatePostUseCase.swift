//
//  CreatePostUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//

import Foundation

class CreatePostUseCase {
    static let shared = CreatePostUseCase()
    private let postRepository = PostRepository.shared

    private init() {}
    
    func execute(post: Post) async throws -> Post {
        try await postRepository.createPost(post: post)
    }
}
