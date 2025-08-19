//
//  DeletePostUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 17.08.25.
//

import Foundation

class DeletePostUseCase {
    private let postRepository = PostRepository.shared
    
    func execute(id: Int) async throws {
        return try await postRepository.deletePost(id: id)
    }
    
    
}
