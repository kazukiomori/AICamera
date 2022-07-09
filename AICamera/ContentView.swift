//
//  ContentView.swift
//  AICamera
//
//  Created by Kazuki Omori on 2022/07/07.
//

import SwiftUI

struct ContentView: View {
    @State private var image:UIImage?
    @State private var showCameraView = false
    
    var body: some View {
        VStack{
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
            }
            Button(action: {showCameraView.toggle()}, label: {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
            })
            Button(action: {}, label: {
                Text("AIの解析")
            })
        }
        .sheet(isPresented: $showCameraView) {
            ImagePickerSwiftUI(image: $image, showCameraView: $showCameraView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
