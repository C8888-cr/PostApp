//
//  PostViewModel.swift
//  PostApp
//
//  Created by Christiane Roth on 04.08.25.
//
/*
import SwiftUI
import Foundation


class PostViewModel: ObservableObject {
    
    private let repositorty: PostRepositoryProtocol = PostRepository.shared
    
    
    @Published var posts: [Post] = []
    @Published var currentPost: Post?
    @Published var isLoading = false
    
   
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
    

     func fetchPosts(userId: Int? = nil) {
     isLoading = true
     
     if let userId = userId {
     repositorty.getPostById(id: userId) { [weak self] result in
     DispatchQueue.main.async { // Wichtig für UI-Updates
     self?.isLoading = false // Laden beendet
     switch result {
     case .success(let post):
     self?.currentPost = post
     // Wenn du eine Liste von Posts anzeigen willst, wenn nur ein User ID gefiltert wird,
     // und dieser einen einzigen Post zurückgibt:
     if let post = post {
     self?.posts = [post] // Setze die Liste auf diesen einen Post
     } else {
     self?.posts = [] // Oder leere Liste, wenn kein Post gefunden wurde
     self?.currentPost = nil
     }
     case .failure(let error):
     self?.handleError(error.localizedDescription) // Fehlerbehandlung nutzen
     }
     }
     }
     } else {
     repositorty.getAllPosts { [weak self] result in
     DispatchQueue.main.async { // Wichtig für UI-Updates
     self?.isLoading = false // Laden beendet
     switch result {
     case .success(let posts):
     self?.posts = posts
     case .failure(let error):
     self?.handleError(error.localizedDescription) 
     }
     }
     }
     }
     
     */

    import Foundation
    import SwiftUI
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let repositorty: PostRepositoryProtocol = PostRepository.shared
    let getAllPostsUseCase: GetAllPostsUseCase? // Optional
    let createPostUseCase: CreatePostUseCase? // Optional
    init(getAllPostsUseCase: GetAllPostsUseCase? = nil, createPostUseCase: CreatePostUseCase? = nil) {
        self.getAllPostsUseCase = getAllPostsUseCase
        self.createPostUseCase = createPostUseCase
    }
    @MainActor
    func loadPosts() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                if let getAllPostsUseCase = getAllPostsUseCase {
                    posts = try await getAllPostsUseCase.execute()
                } else {
                    print("No getAllPostsUseCase provided")
                }
            } catch {
                showAlert = true
                errorMessage = "Failed to load posts: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    @MainActor
    func createPost(post: Post) {
        Task {
            do {
                if let createPostUseCase = createPostUseCase {
                    
                    let newPost = try await createPostUseCase.execute(post: post)
                    posts.append(newPost) // Oder posts.append(post), wenn die ID nicht geändert wird
                } else {
                    print("No createPostUseCase provided")
                    return
                }
            } catch {
                errorMessage = "Failed to create post: \(error.localizedDescription)"
                showAlert = true // Wichtig: Alert anzeigen
            }
        }
    }
}
