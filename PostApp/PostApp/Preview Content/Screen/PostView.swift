
import SwiftUI


struct PostView: View {
    
    @EnvironmentObject private var viewModel: PostViewModel
  
       
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.posts) { post in
                    NavigationLink(value: post) { SinglePostView(post: post)
                    }
                }
            }
                    
        .navigationDestination(for: Post.self) { detailPost in
            SinglePostView(post: detailPost)
        }
  
            .onAppear {
                viewModel.loadPosts()
                print(viewModel.posts)
            }
            
            .alert(isPresented: $viewModel.showAlert) {
                
            Alert(title: Text("Fehler"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
 PostView()
            .environmentObject(PostViewModel())
    }


