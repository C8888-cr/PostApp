
import Foundation

class UpdatePostUseCase {
    
    private let postRepository: PostRepositoryProtocol
    
    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    
 
    func execute (id: Int, title: String, body: String) async throws -> Post {
        try await postRepository.updatePost(post: Post(id: id, title: title, body: body))
        }
    }
