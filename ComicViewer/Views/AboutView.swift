import SwiftUI

struct AboutView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading) {
                Text("Comic Viewer")
                    .font(.largeTitle)
                Text("by PWS Academy")
                    .font(.title3)
            }
            Text("""
                This app is [open source](https://github.com/pwsacademy/comicviewer/) and made for educational purposes only.
                All content is provided by [XKCD](https://xkcd.com) under the [CC BY-NC 2.5](https://creativecommons.org/licenses/by-nc/2.5/) license.
                """)
                .foregroundStyle(.secondary)
        }
        .scenePadding()
    }
}

#Preview {
    AboutView()
}
