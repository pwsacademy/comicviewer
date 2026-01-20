import SwiftUI

@main
struct ComicViewerApp: App {

    var body: some Scene {
        Window("Comic Viewer", id: "comic") {
            RootLoadingView()
        }
        .commands {
            AboutCommand()
            FavoriteCommand()
            SaveCommand()
            ZoomCommands()
            SidebarCommands()
            NavigationCommands()
            HelpCommand()
            // Hide unused menu items.
            CommandGroup(replacing: .undoRedo) { }
            CommandGroup(replacing: .pasteboard) { }
            CommandGroup(replacing: .systemServices) { }
        }
        .defaultSize(.init(width: 800, height: 600))
        
        Window("About", id: "about") {
            AboutView()
                .windowMinimizeBehavior(.disabled)
                .windowResizeBehavior(.disabled)
        }
        .restorationBehavior(.disabled)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        
        Settings {
            SettingsView()
        }
    }
}
