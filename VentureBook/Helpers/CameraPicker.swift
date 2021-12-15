//
//  CameraPicker.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-11-13.
//

import Foundation
import SwiftUI
import PhotosUI

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        //        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraPicker>) {}
    
    func makeCoordinator() -> CameraPicker.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        var parent: CameraPicker
        
        init(parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                self.parent.image = image
                self.parent.isPresented.toggle()
                picker.dismiss(animated: true)
                
                //save image to Photo Library
                PHPhotoLibrary.shared().performChanges({
                    
                    let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    PHAssetCollectionChangeRequest(for: PHAssetCollection())?.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
                    
                },
                completionHandler: {success, error in
                    if !success{
                        print(#function, "Error saving image in Photo Library \(error?.localizedDescription ?? "No error found")")
                    }
                })
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isPresented.toggle()
        }
    }
}
