import UIKit

class ImageSaver: NSObject {
    
    public  var successHandler: (() -> Void)?
    public   var errorHandler: ((Error) -> Void)?
    
    public override init(){}
    
    public func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
