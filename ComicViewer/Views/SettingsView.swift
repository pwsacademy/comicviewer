import SwiftUI

struct SettingsView: View {
    
    @AppStorage(.initialSelectionKey)
    private var initialSelection: AppSettings.InitialSelection = .default
    
    var body: some View {
        Form {
            Picker("New windows open with", selection: $initialSelection) {
                ForEach(AppSettings.InitialSelection.allCases, id: \.self) { option in
                    Text(option.description).tag(option)
                }
            }
        }
        .navigationTitle("Settings")
        .scenePadding()
    }
}

#Preview {
    SettingsView()
}
