
import Foundation

class UpdatePostUseCase {
    static let shared = UpdatePostUseCase()
        private init() {}
    
    private let postRepository = PostRepository.shared

    func execute (post: Post) async throws -> Post {
        try await postRepository.updatePost(post: post)
        }
    }
