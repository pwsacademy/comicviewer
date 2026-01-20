import SwiftUI

/// Menu items for navigating to a different comic.
struct NavigationCommands: Commands {
    
    @FocusedValue(ComicStore.self) private var comicStore
    
    var body: some Commands {
        CommandMenu("Go") {
            Section {
                Button("First") {
                    Task { await comicStore!.selectFirst() }
                }
                .keyboardShortcut(.leftArrow, modifiers: [.command, .shift])
                .disabled(comicStore?.hasPrevious == false)
                
                Button("Previous") {
                    Task { await comicStore!.selectPrevious() }
                }
                .keyboardShortcut(.leftArrow, modifiers: .command)
                .disabled(comicStore?.hasPrevious == false)
                
                Button("Random") {
                    Task { await comicStore!.selectRandom() }
                }
                .keyboardShortcut("r", modifiers: .command)
                .disabled(comicStore == nil)
                
                Button("Next") {
                    Task { await comicStore!.selectNext() }
                }
                .keyboardShortcut(.rightArrow, modifiers: .command)
                .disabled(comicStore?.hasNext == false)
                
                Button("Last") {
                    Task { await comicStore!.selectLast() }
                }
                .keyboardShortcut(.rightArrow, modifiers: [.command, .shift])
                .disabled(comicStore?.hasNext == false)
            }
            Section {
                Button("Specific Comic…") {
                    comicStore!.isShowingGoToSheet = true
                }
                .keyboardShortcut("g", modifiers: .command)
                .disabled(comicStore == nil)
            }
        }
    }
}
