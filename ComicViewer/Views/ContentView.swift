import SwiftUI

struct ContentView: View {
    
    @Environment(ComicStore.self) private var comicStore
    @Environment(FavoritesStore.self) private var favoritesStore
    
    var body: some View {
        @Bindable var comicStore = comicStore
        VStack(spacing: 20) {
            if let comic = comicStore.selectedComic,
               let image = comicStore.imageForSelectedComic {
                ComicView(comic, image, zoom: comicStore.zoomLevel)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Spacer()
            NavigationControls()
        }
        .toolbar {
            zoomButtons
            ToolbarSpacer()
            favoriteButton
        }
        .alert("Error", isPresented: $comicStore.isShowingError) { } message: {
            Text(comicStore.errorMessage ?? "An unknown error occurred.")
        }
        .sheet(isPresented: $comicStore.isShowingGoToSheet) {
            GoToSheet(selectedNumber: comicStore.selectedComic?.number ?? 1)
        }
    }
    
    private var zoomButtons: some ToolbarContent {
        ToolbarItemGroup {
            Button("Zoom Out", systemImage: "minus.magnifyingglass", action: comicStore.zoomOut)
                .disabled(comicStore.selectedComic == nil)
            
            Button("Actual Size", systemImage: "1.magnifyingglass", action: comicStore.zoomActual)
                .disabled(
                    comicStore.selectedComic == nil ||
                    comicStore.zoomLevel == 1
                )
            
            Button("Zoom In", systemImage: "plus.magnifyingglass", action: comicStore.zoomIn)
                .disabled(comicStore.selectedComic == nil)
        }
    }
    
    private var favoriteButton: some ToolbarContent {
        ToolbarItem {
            if favoritesStore.contains(comicStore.selectedComic) {
                Button {
                    favoritesStore.remove(comicStore.selectedComic!)
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
                .accessibilityLabel("remove from favorites")
                .disabled(comicStore.selectedComic == nil)
            }
            else {
                Button {
                    favoritesStore.add(comicStore.selectedComic!)
                } label: {
                    Image(systemName: "heart")
                }
                .accessibilityLabel("add to favorites")
                .disabled(comicStore.selectedComic == nil)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ComicStore.example(initialSelection: .random))
        .environment(FavoritesStore.example())
        .frame(minWidth: 400, minHeight: 600)
        .scenePadding()
}
