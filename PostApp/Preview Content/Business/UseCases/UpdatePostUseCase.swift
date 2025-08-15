
import Foundation

class UpdatePostUseCase {
    
    private let postRepository = PostRepository.shared

    func execute (post: Post) async throws -> Post {
       return try await postRepository.updatePost(post: post)
        }
    }
