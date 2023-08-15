import UniformTypeIdentifiers
import SwiftUI

struct CameraMoviePickerView: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss
    @Binding var movieUrl: URL?

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.sourceType = .camera

        picker.delegate = context.coordinator
        picker.mediaTypes = [UTType.movie.identifier]
        picker.videoQuality = .typeHigh

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let parent: CameraMoviePickerView

        init(_ parent: CameraMoviePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

            guard let movieURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                return
            }

            parent.movieUrl = movieURL
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
