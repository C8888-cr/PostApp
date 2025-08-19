  
import Foundation


class GetPostByIdUseCase {
    static let shared = GetPostByIdUseCase()
        private init() {}
    
    private let postRepository = PostRepository.shared


    func execute() async throws -> Post {
        try await postRepository.getPostById(id: Int())
        }
    }
