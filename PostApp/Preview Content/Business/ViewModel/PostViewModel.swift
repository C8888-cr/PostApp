import SwiftUI


@MainActor

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var alertMessage = ""

      func loadPosts() async {
          isLoading = true
          do {
              posts = try await GetAllPostsUseCase.shared.execute()
          } catch
                let error as RepositoryError {
                    self.errorMessage = error.errorDescription
          } catch {
              self.errorMessage = "Ein unbekannter Fehler ist aufgetreten"
          }
          isLoading = false
      }
  }
