import SwiftUI

struct RootView: View {
        
    @State private var splitViewVisibility = NavigationSplitViewVisibility.automatic
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            FavoritesSidebar()
                .environment(\.splitViewVisibility, splitViewVisibility)
        } detail: {
            ContentView()
                .scenePadding()
        }
    }
}

#Preview {
    RootView()
        .environment(ComicStore.example(initialSelection: .random))
        .environment(FavoritesStore.example())
        .frame(minWidth: 600, minHeight: 600)
}
