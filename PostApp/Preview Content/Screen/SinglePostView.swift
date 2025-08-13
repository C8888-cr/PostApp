//
//  SinglePostView.swift
//  PostApp
//
//  Created by Christiane Roth on 06.08.25.
//

import SwiftUI

struct SinglePostView: View {
    

    let post: Post
    var body: some View {
   
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    Text("Von User: \(post.userId ?? 0)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Post ID: \(post.id ?? 0)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
           
                Text(post.body ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.white.opacity(0.9))
            .cornerRadius(8)
       
        }
    }

#Preview {

    SinglePostView(post: .init(userId: 1, id: 1, title: "test", body: "test"))
    
}
