import AppKit
import Foundation

/// A repository that fetches comics from local files.
///
/// This is useful for previews in Xcode.
///
/// Use ``ComicStore/example(initialSelection:)`` to create a store that uses this repository.
class ExampleComicRepository: ComicRepository {
    
    private let comics: [Comic]
    
    init() {
        let url = Bundle.main.url(forResource: "examples", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let comics = try! JSONDecoder().decode([Comic].self, from: data)
        self.comics = comics.sorted { $0.number < $1.number }
    }
    
    func fetchLatestComicNumber() -> Int {
        comics.count
    }
    
    func fetchComic(_ number: Int) -> Comic {
        comics[number - 1]
    }
    
    func fetchImage(for comic: Comic) -> ComicImage {
        let fileName = comic.image.lastPathComponent
        let url = Bundle.main.urlForImageResource(fileName)!
        let data = try! Data(contentsOf: url)
        let size = NSImage(data: data)!.size
        return ComicImage(data: data, width: size.width, height: size.height)
    }
}
