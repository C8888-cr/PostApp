//
//  CreatePostUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//


import Foundation

class CreatePostUseCase {

    private let postRepository: PostRepositoryProtocol
    

        init(postRepository: PostRepositoryProtocol) {
            self.postRepository = postRepository
        }
    

    func execute(post: Post) async throws -> Post {
           return try await postRepository.createPost(post: post)
 
            }
        }
    

