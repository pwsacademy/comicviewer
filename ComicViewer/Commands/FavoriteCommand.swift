import SwiftUI

/// A menu item to (un)favorite the selected comic.
struct FavoriteCommand: Commands {
    
    @FocusedValue(ComicStore.self) private var comicStore
    @FocusedValue(FavoritesStore.self) private var favoritesStore
    
    var body: some Commands {
        CommandGroup(before: .saveItem) {
            Section {
                Group {
                    if favoritesStore?.contains(comicStore?.selectedComic) == true {
                        Button("Remove from Favorites", systemImage: "heart.fill") {
                            favoritesStore!.remove(comicStore!.selectedComic!)
                        }
                    } else {
                        Button("Add to Favorites", systemImage: "heart") {
                            favoritesStore!.add(comicStore!.selectedComic!)
                        }
                    }
                }
                .keyboardShortcut("f", modifiers: .command)
                .disabled(comicStore?.selectedComic == nil)
            }
        }
    }
}
