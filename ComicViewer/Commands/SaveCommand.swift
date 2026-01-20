import AppKit
import Logging
import SwiftUI

/// A menu item to save the selected comic to disk.
struct SaveCommand: Commands {
    
    @FocusedValue(ComicStore.self) private var comicStore
    
    var body: some Commands {
        CommandGroup(before: .saveItem) {
            Button("Save…", systemImage: "square.and.arrow.down") {
                Task { await save() }
            }
            .keyboardShortcut("s", modifiers: .command)
            .disabled(comicStore?.selectedComic == nil)
        }
    }
    
    private func save() async {
        guard let comicStore,
              let comic = comicStore.selectedComic,
              let image = comicStore.imageForSelectedComic else {
            logger.warning("""
                Cancelling save.
                The selection may have changed since the action was started.
                """)
            return
        }
        let panel = NSSavePanel()
        panel.title = "Save Comic"
        panel.nameFieldStringValue = comic.image.lastPathComponent
        let response = await panel.begin()
        if response == .OK, let url = panel.url {
            do {
                try image.data.write(to: url, options: .atomic)
            } catch {
                logger.error("Failed to save this file.", metadata: [
                    "url": "\(url)",
                    "error": "\(error)"
                ])
                comicStore.isShowingError = true
                comicStore.errorMessage = "An error occurred while saving this file."
            }
        }
    }
}
