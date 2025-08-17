import SwiftUI


@MainActor

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private var useCaseProvider: UseCaseProvider?
    init() {
        print("PostViewModel init")
    }
    
    func setupUseCaseProvider(_ provider: UseCaseProvider) {
        self.useCaseProvider = provider
    }
    func loadPosts() {
        guard let useCaseProvider = useCaseProvider else {
            errorMessage = "UseCaseProvider ist nicht initialisiert"
            showAlert = true
            alertMessage = errorMessage ?? "Ein unbekannter Fehler ist aufgetreten."
            return
        }
        
        isLoading = true
        errorMessage = nil
        print("loadPosts() call")
        Task {
            do {
                posts = try await useCaseProvider.getAllPostsUseCase.execute()
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = "Failed to load posts: \(error.localizedDescription)"
                showAlert = true
                alertMessage = errorMessage ?? "Ein unbekannter Fehler ist aufgetreten."
            }
        }
    }
}
