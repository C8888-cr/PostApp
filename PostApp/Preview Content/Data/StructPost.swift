//
//  StructPost.swift
//  PostApp
//
//  Created by Christiane Roth on 04.08.25.
//

import SwiftUI

struct Post: Identifiable, Codable, Equatable, Hashable {
    var userId: Int?
    var id: Int? 
    var title: String?
    var body: String?
    

    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}
