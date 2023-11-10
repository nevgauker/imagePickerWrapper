//
//  File.swift
//  
//
//  Created by Rotem Nevgauker on 10/11/2023.
//

import PhotosUI
import SwiftUI

@available(iOS 14.0, *)
struct ImagePicker:UIViewControllerRepresentable{
    
    class Coordinator:  NSObject, PHPickerViewControllerDelegate{
        var parent: ImagePicker
        public init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)
            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }
            
            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
    }
    
    @Binding public var image: UIImage?
    
    public init(image: Binding<UIImage?>) {
        self._image = image
    }
    
    
    typealias UIViewControllerType = PHPickerViewController
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}



