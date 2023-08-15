import SwiftUI
import AVKit

struct MoviePlayerView: View {

    @Environment(\.dismiss) private var dismiss
    private let movieUrl: URL?

    init(with movieUrl: URL?) {
        self.movieUrl = movieUrl
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }

                Spacer()
                    .frame(width: 16)
            }
            VideoPlayer(player: AVPlayer(url: movieUrl!))
        }
    }
}
