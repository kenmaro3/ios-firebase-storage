import SwiftUI
import Foundation


struct Parent: View{
    
    var body: some View {
        NavigationView{
            TabView{
                PhotoUpload()
                    .tabItem {
                        Image(systemName: "photo")
                        Text("Photo")
                    }
                
                VideoUpload()
                    .tabItem {
                        Image(systemName: "video")
                        Text("Video")
                    }
            }
            .accentColor(.black)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


struct Parent_Previews: PreviewProvider {
    static var previews: some View {
        Parent()
    }
}
