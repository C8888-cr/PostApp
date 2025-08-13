//
//  getAllPostsUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 12.08.25.
//



import Foundation
import SwiftUI

class GetAllPostsUseCase {
    private let postRepository: PostRepositoryProtocol
    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    func execute() async throws -> [Post] {
        return try await postRepository.getAllPosts()
    }
}
