import SwiftUI
@main
struct PostAppApp: App {
    // Erstelle das ViewModel einmal und markiere es mit @StateObject
    @StateObject private var viewModel = PostViewModel(
        getAllPostsUseCase: GetAllPostsUseCase(postRepository: PostRepository()),
        createPostUseCase: CreatePostUseCase(postRepository: PostRepository())
    )
    var body: some Scene {
        WindowGroup {
            PostView() // Keine manuelle Initialisierung des ViewModels mehr!
                .environmentObject(viewModel) // Injiziere das ViewModel in die Umgebung
        }
    }
}
