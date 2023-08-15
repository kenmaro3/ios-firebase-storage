//
//  VideoUpload.swift
//  FirebaseStorageIos
//
//  Created by Kentaro Mihara on 2023/08/15.
//

import SwiftUI
import FirebaseStorage

struct VideoUpload: View {
    @State private var movieUrl: URL?
    @State private var showCameraMoviePickerView = false
    @State private var showPhotoLibraryMoviePickerView = false
    @State private var showMoviePlayerView = false

    private var canPlayVideo: Bool {
        movieUrl != nil
    }

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Button {
                showCameraMoviePickerView = true
            } label: {
                Text("Camera Movie Picker")
            }

            Button {
                showPhotoLibraryMoviePickerView = true
            } label: {
                Text("Photo Library Movie Picker")
            }

            Button {
                showMoviePlayerView = true

                guard let url = movieUrl else {
                    return
                }
                print(url)
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: 50,
                           height:50)
                    .foregroundColor(canPlayVideo ? .accentColor : .gray)
            }
            .disabled(!canPlayVideo)
            
            Button {
                guard let url = movieUrl else {
                    return
                }
                print(url)
                let storage = Storage.storage()
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
                let uniqueId: String = UUID().uuidString
                var spaceRef = storageRef.child("videos/\(uniqueId).mp4")
                let metadata = StorageMetadata()
                metadata.contentType = "video/mp4"
                
                do{
                    let data = try Data(contentsOf: url)
                    let uploadTask = spaceRef.putData(data, metadata: metadata) { (metadata, error) in
                        guard let metadata = metadata else {
                            // Uh-oh, an error occurred!
                            return
                        }
                        // Metadata contains file metadata such as size, content-type.
                        let size = metadata.size
                        // You can also access to download URL after upload.
                        spaceRef.downloadURL { (url, error) in
                            guard let downloadURL = url else {
                                // Uh-oh, an error occurred!
                                return
                            }
                        }
                    }

                }catch{
                    
                }
                
    
                
            } label: {
                Text("Upload video")
            }
            .disabled(!canPlayVideo)

            Spacer()
        }
        .fullScreenCover(isPresented: $showCameraMoviePickerView) {
            CameraMoviePickerView(movieUrl: $movieUrl)
        }
        .fullScreenCover(isPresented: $showPhotoLibraryMoviePickerView) {
            PhotoLibraryMoviePickerView(movieUrl: $movieUrl)
        }
        .fullScreenCover(isPresented: $showMoviePlayerView) {
            MoviePlayerView(with: movieUrl)
        }
    }
}

#Preview {
    VideoUpload()
}
