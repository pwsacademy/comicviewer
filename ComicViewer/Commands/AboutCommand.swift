import SwiftUI

/// A menu item to open the "About Comic Viewer" window.
struct AboutCommand: Commands {
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some Commands {
        CommandGroup(replacing: .appInfo) {
            Button("About Comic Viewer", systemImage: "info.circle") {
                openWindow(id: "about")
            }
        }
    }
}
