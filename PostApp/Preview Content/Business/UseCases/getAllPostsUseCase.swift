//
//  getAllPostsUseCase.swift
//  PostApp
//
//  Created by Christiane Roth on 12.08.25.
//



import Foundation
import SwiftUI

class GetAllPostsUseCase {
    static let shared = GetAllPostsUseCase()
    private let postRepository = PostRepository.shared
    
    private init() {}
    
    func execute() async throws -> [Post] {
        try await postRepository.getAllPosts()
    }
}

