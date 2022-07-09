//
//  ContentView.swift
//  AICamera
//
//  Created by Kazuki Omori on 2022/07/07.
//

import SwiftUI
import Vision

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
            Button(action:{
                    if image != nil {
                        imageAnalizer(image: image!)
                    }
                }, label: {
                Text("AIの解析")
            })
        }
        .sheet(isPresented: $showCameraView) {
            ImagePickerSwiftUI(image: $image, showCameraView: $showCameraView)
        }
    }
    func imageAnalizer(image:UIImage) {
        let url = Bundle.main.url(forResource: "MobileNetV2FP16", withExtension: "mlmodelc")!
        
        let model = try! MLModel(contentsOf: url)
        let coreMLModel = try! VNCoreMLModel(for: model)
        
        let request = VNCoreMLRequest(model: coreMLModel) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else { return }
            
            for result in results[0...4] {
                print(result.confidence * 100, result.identifier)
            }
        }
        
        request.imageCropAndScaleOption = .centerCrop
        
        let ciImage = CIImage(image: image)!
        
        let handler = VNImageRequestHandler(cgImage: ciImage as! CGImage)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
