// GetPostByIdUseCase.swift
import Foundation
class GetPostByIdUseCase {
    

    private let postRepository: PostRepositoryProtocol
    
 
    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    

    func execute() async throws -> Post {
        return try await postRepository.getPostById(_id: Int())
        }
    }
