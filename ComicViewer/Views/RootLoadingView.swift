import Logging
import SwiftUI

/// View that shows a placeholder (or error) while the comic store is loading.
///
/// This step simplifies the rest of the application.
/// Child views can safely assume the comic store has been initialized.
struct RootLoadingView: View {
    
    @AppStorage(.initialSelectionKey)
    private var initialSelection: AppSettings.InitialSelection = .default
    
    @State private var comicStore: ComicStore?
    @State private var favoritesStore = FavoritesStore()
    @State private var loadingFailed = false
    
    var body: some View {
        Group {
            if let comicStore {
                RootView()
                    .environment(comicStore)
                    .environment(favoritesStore)
            } else if loadingFailed {
                ContentUnavailableView(
                    "Error",
                    systemImage: "network.slash",
                    description: Text("The application failed to connect to the server.")
                )
            } else {
                ContentUnavailableView(
                    "Loading",
                    systemImage: "network",
                    description: Text("Please wait while we load a comic for you...")
                )
            }
        }
        .focusedSceneValue(comicStore)
        .focusedSceneValue(favoritesStore)
        .task {
            do {
                comicStore = try await ComicStore(
                    initialSelection: initialSelection,
                    repository: OnlineComicRepository()
                )
            } catch {
                logger.critical("Failed to create a comic store.", metadata: [
                    "error": "\(error)"
                ])
                loadingFailed = true
            }
        }
    }
}

#Preview {
    RootLoadingView()
        .frame(width: 600, height: 600)
}
