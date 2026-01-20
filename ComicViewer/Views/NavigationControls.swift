import SwiftUI

struct NavigationControls: View {
    
    @Environment(ComicStore.self) private var comicStore
    
    var body: some View {
        HStack {
            Button {
                Task { await comicStore.selectFirst() }
            } label: {
                Image(systemName: "backward.end.circle")
                    .font(.title)
            }
            .accessibilityLabel("first")
            .disabled(!comicStore.hasPrevious)
            
            Button {
                Task { await comicStore.selectPrevious() }
            } label: {
                Image(systemName: "backward.circle")
                    .font(.title)
            }
            .accessibilityLabel("previous")
            .disabled(!comicStore.hasPrevious)
            
            Button {
                Task { await comicStore.selectRandom() }
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.title)
            }
            .accessibilityLabel("random")
            
            Button {
                Task { await comicStore.selectNext() }
            } label: {
                Image(systemName: "forward.circle")
                    .font(.title)
            }
            .accessibilityLabel("next")
            .disabled(!comicStore.hasNext)
            
            Button {
                Task { await comicStore.selectLast() }
            } label: {
                Image(systemName: "forward.end.circle")
                    .font(.title)
            }
            .accessibilityLabel("last")
            .disabled(!comicStore.hasNext)
        }
    }
}

#Preview {
    NavigationControls()
        .environment(ComicStore.example(initialSelection: .random))
        .scenePadding()
}
