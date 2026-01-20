import SwiftUI

/// A menu items to control the zoom level.
struct ZoomCommands: Commands {
    
    @FocusedValue(ComicStore.self) private var comicStore
    
    var body: some Commands {
        CommandGroup(before: .sidebar) {
            Section {
                Button("Actual Size", systemImage: "1.magnifyingglass") {
                    comicStore!.zoomActual()
                }
                .keyboardShortcut("0", modifiers: .command)
                .disabled(
                    comicStore?.selectedComic == nil ||
                    comicStore?.zoomLevel == 1
                )
                
                Button("Zoom In", systemImage: "plus.magnifyingglass") {
                    comicStore!.zoomIn()
                }
                .keyboardShortcut("+", modifiers: .command)
                .disabled(comicStore?.selectedComic == nil)
                
                Button("Zoom Out", systemImage: "minus.magnifyingglass") {
                    comicStore!.zoomOut()
                }
                .keyboardShortcut("-", modifiers: .command)
                .disabled(comicStore?.selectedComic == nil)
            }
        }
    }
}
