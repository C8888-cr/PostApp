import SwiftUI
@main
struct PostAppApp: App {

    var body: some Scene {
        WindowGroup {
            PostView()
                .environmentObject(UseCaseProvider.shared)
              
        }
    }
}

