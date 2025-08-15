  
import Foundation


class GetPostByIdUseCase {
    
    private let postRepository = PostRepository.shared

   
    

    func execute() async throws -> Post {
        return try await postRepository.getPostById(id: Int())
        }
    }
