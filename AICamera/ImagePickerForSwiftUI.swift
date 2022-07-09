//
//  ImagePickerForSwiftUI.swift
//  AIImageApp
//
//  Created by nokkun on 2021/10/20.
//

import Foundation
import SwiftUI

struct ImagePickerSwiftUI : UIViewControllerRepresentable{
    @Binding var image:UIImage?
    @Binding var showCameraView:Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {

        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator

        if UIImagePickerController.isSourceTypeAvailable(.camera){
            viewController.sourceType = .camera
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
        let parent: ImagePickerSwiftUI
        
        init(_ parent:ImagePickerSwiftUI) {
            self.parent = parent
        }
        
        //ユーザが写真撮影したり、画像を選択したら、画像を変数に保存する。
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                self.parent.image = uiImage
            }
            //元の画面に戻る
            self.parent.showCameraView = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.showCameraView = false
        }

    }
}
