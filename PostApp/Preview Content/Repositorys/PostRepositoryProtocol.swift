//
//  PostRepositoryProtocol.swift
//  PostApp
//
//  Created by Christiane Roth on 10.08.25.
//
import Foundation


protocol PostRepositoryProtocol {
    func getAllPosts() async throws -> [Post]
    func getPostsByUserId(_ userId: Int) async throws -> [Post]
    func getPostById(_id: Int) async throws -> Post
    func createPost(post: Post) async throws -> Post
    func updatePost(post: Post) async throws -> Post
}
