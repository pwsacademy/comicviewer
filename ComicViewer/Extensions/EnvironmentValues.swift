import SwiftUI

extension EnvironmentValues {
    
    /// The visibility of the leading columns in the navigation split view.
    ///
    /// We use this to check if the sidebar is currently showing.
    @Entry var splitViewVisibility: NavigationSplitViewVisibility = .automatic
}
