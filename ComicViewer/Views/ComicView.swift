import SwiftUI

struct ComicView: View {
        
    private let comic: Comic
    private let image: ComicImage
    private let zoom: Double
    
    init(_ comic: Comic, _ image: ComicImage, zoom: Double = 1.0) {
        self.comic = comic
        self.image = image
        self.zoom = zoom
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text(comic.title)
                    .font(.title)
                Text("#\(number) - \(date)")
                    .foregroundStyle(.secondary)
            }
            GeometryReader { proxy in
                let scale = image.scaleToFit(
                    availableWidth: proxy.size.width,
                    availableHeight: proxy.size.height
                ) * zoom
                ScrollView([.horizontal, .vertical]) {
                    let imageView = Image(nsImage: .init(data: image.data)!)
                    return imageView
                        .scaleEffect(scale)
                        .frame(width: image.width * scale, height: image.height * scale)
                        .draggable(imageView)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .scrollBounceBehavior(.basedOnSize, axes: [.horizontal, .vertical])
            }
            Text(comic.description)
                .frame(maxWidth: 600)
        }
        .navigationSubtitle("#\(number) - \(comic.title)")
    }
    
    private var number: String {
        comic.number.formatted(.number.grouping(.never))
    }
    
    private var date: String {
        comic.date.formatted(date: .abbreviated, time: .omitted)
    }
}

#Preview {
    ComicView(.example(), .example())
        .frame(width: 400, height: 400)
        .scenePadding()
}
