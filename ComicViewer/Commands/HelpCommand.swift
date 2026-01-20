import SwiftUI

/// A menu item that links to the app's repository on GitHub.
struct HelpCommand: Commands {
    
    @Environment(\.openURL) private var openURL
    
    var body: some Commands {
        CommandGroup(replacing: .help) {
            Button("Source Code") {
                openURL(URL(string: "https://github.com/pwsacademy/comicviewer/")!)
            }
        }
    }
}
