import Foundation
import PhotosUI
import SwiftUI

class Coordinator: NSObject, PHPickerViewControllerDelegate {

    let parent: PhotoLibraryMoviePickerView

    init(_ parent: PhotoLibraryMoviePickerView) {
        self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        parent.dismiss()

        guard let provider = results.first?.itemProvider else {
            return
        }

        let typeIdentifier = UTType.movie.identifier

        if provider.hasItemConformingToTypeIdentifier(typeIdentifier) {

            provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error = error {
                    print("error: \(error)")
                    return
                }
                if let url = url {
                    let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                    let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                    try? FileManager.default.copyItem(at: url, to: newUrl)
                    self.parent.movieUrl = newUrl
                }
            }
        }
    }
}
