//
//  UseCaseProvider.swift
//  PostApp
//
//  Created by Christiane Roth on 15.08.25.
//
import Foundation
import SwiftUI


class UseCaseProvider: ObservableObject {
    static let shared = UseCaseProvider()
    public let getAllPostsUseCase = GetAllPostsUseCase()
    public let getPostsByUserIdUseCase = GetPostsByUserIdUseCase()
    public let createPostUseCase = CreatePostUseCase()
    public let updatePostUseCase = UpdatePostUseCase()
    
    private init() {
        print("UseCaseProvider initialized")
    }
}
