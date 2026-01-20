import SwiftUI

struct GoToSheet: View {
    
    @Environment(ComicStore.self) private var comicStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedNumber: Int
    
    private var isValid: Bool {
        (1...comicStore.lastComicNumber).contains(selectedNumber)
    }
    
    init(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
    }
    
    var body: some View {
        Form {
            Text("Which comic would you like to see?")
                .font(.headline)
            TextField("Number", value: $selectedNumber, format: .number.grouping(.never))
                .labelsHidden()
            if !isValid {
                Text("Please enter a number between 1 and \(comicStore.lastComicNumber)")
                    .foregroundStyle(.red)
                    .font(.callout.bold())
            }
            HStack {
                Spacer()
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
                Button("Go") {
                    Task { await comicStore.selectSpecific(number: selectedNumber) }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValid)
                .keyboardShortcut(.defaultAction)
            }
        }
        .fixedSize()
        .scenePadding()
    }
}

#Preview {
    GoToSheet(selectedNumber: 2)
        .environment(ComicStore.example(initialSelection: .random))
}
