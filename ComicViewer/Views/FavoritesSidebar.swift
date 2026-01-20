import SwiftUI

struct FavoritesSidebar: View {
    
    @Environment(ComicStore.self) private var comicStore
    @Environment(FavoritesStore.self) private var favoritesStore
    @Environment(\.splitViewVisibility) private var splitViewVisibility
    
    @AppStorage(.sortFavoritesAscendingKey)
    private var sortFavoritesAscending = false
    
    private var sortedFavorites: [FavoritesEntry] {
        favoritesStore.favorites.sorted {
            if sortFavoritesAscending {
                $0.number < $1.number
            } else {
                $0.number > $1.number
            }
        }
    }
        
    var body: some View {
        @Bindable var favoritesStore = favoritesStore
        VStack {
            HStack {
                Text("Favorites")
                    .font(.title.bold())
                Spacer()
                Image(systemName: "heart.fill")
            }
            .padding()
            List(sortedFavorites, id: \.self, selection: $favoritesStore.selectedFavorite) { favorite in
                NavigationLink(value: favorite) {
                    VStack(alignment: .leading) {
                        Text(favorite.title)
                            .font(.headline)
                        Text("#\(formattedNumber(favorite)) - \(formattedDate(favorite))")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .listRowSeparator(.hidden)
                .padding(5)
            }
            // Forward the selection to the comic store.
            .onChange(of: favoritesStore.selectedFavorite) { oldValue, newValue in
                if let newValue {
                    Task { await comicStore.selectSpecific(number: newValue.number) }
                }
            }
            // Clear the selected favorite when a new comic is selected.
            .onChange(of: comicStore.selectedComic) { oldValue, newValue in
                // The selected comic will transition through nil while the comic is loading,
                // so we need to ignore that case here.
                if let newValue {
                    if newValue.number != favoritesStore.selectedFavorite?.number {
                        favoritesStore.selectedFavorite = nil
                    }
                }
            }
        }
        .toolbar {
            if splitViewVisibility == .all {
                Button(
                    sortFavoritesAscending ? "Sort Descending" : "Sort Ascending",
                    systemImage: "arrow.up.arrow.down"
                ) {
                    sortFavoritesAscending.toggle()
                }
            }
        }
        .frame(minWidth: 200)
    }
    
    private func formattedNumber(_ entry: FavoritesEntry) -> String {
        entry.number.formatted(.number.grouping(.never))
    }
    
    private func formattedDate(_ entry: FavoritesEntry) -> String {
        entry.date.formatted(date: .abbreviated, time: .omitted)
    }
}

#Preview {
    NavigationStack {
        FavoritesSidebar()
            .environment(ComicStore.example(initialSelection: .random))
            .environment(FavoritesStore.example())
            .environment(\.splitViewVisibility, .all)
            .frame(width: 350, height: 400)
    }
}
