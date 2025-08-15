import Foundation


class PostRepository {
    
    static let shared = PostRepository()
        private init() {}
    
    private let httpService = HttpClient.shared
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    
    
    func getAllPosts() async throws -> [Post] {
        let url = "\(baseURL)/posts"
            return
                try await httpService.get(url)
    }
    
    func getPostsByUserId(userId: Int) async throws -> [Post] {
        let url = "\(baseURL)/posts?userId=\(userId)"
            return
                try await httpService.get(url)
    }
    
    func getPostById(id: Int) async throws -> Post {
        let url = "\(baseURL)/posts/\(id)"
            return
                try await httpService.get(url)
    }
    
    func createPost(post: Post) async throws -> Post {
        let url = "\(baseURL)/posts"
            return
                try await httpService.post(url, data: post)
    }
    
    func updatePost(post: Post) async throws -> Post {
        let url = "\(baseURL)/posts/\(post.id)"
            return
                try await httpService.put(url, data: post)
    }
}
