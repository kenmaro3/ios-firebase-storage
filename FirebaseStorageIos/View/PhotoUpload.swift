//
//  PhotoUpload.swift
//  FirebaseStorageIos
//
//  Created by Kentaro Mihara on 2023/08/15.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

struct PhotoUpload: View {
    @State private var image:Image?
    @State private var inputImage:UIImage?
    @State private var showingImagePicker = false
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button {
                showingImagePicker = true
            } label: {
                Text("Select Image")
            }
            Button {
                let storage = Storage.storage()
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
                let uniqueId: String = UUID().uuidString
                var spaceRef = storageRef.child("images/\(uniqueId).png")
                let metadata = StorageMetadata()
                metadata.contentType = "image/png"
                
                if let data = inputImage?.pngData(){
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
    
                }
                
            } label: {
                Text("Upload Image")
            }
         //Button triggers ImagePicker
        }.sheet(isPresented: $showingImagePicker) {
            ImagePickerView(image: $inputImage)
        }//if inputImage chagnes, loadImage to show it
        .onChange(of: inputImage) { newValue in
            loadImage()
        }
    }
    
    // showing image
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    PhotoUpload()
}

