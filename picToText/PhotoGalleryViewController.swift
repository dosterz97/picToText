import Foundation
import UIKit

class PhotoGalleryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePicker = UIImagePickerController()
    var readyImage = UIImage()
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false

        present(imagePicker, animated: true, completioin: nil)    
    }


    func detectTextBox(for image: UIImage) {
        ImageToTextClient().gettext(from: image) { [weak self] result in
            guard let result = result else {
                let annotation = Annotation()
                annotation.text = "Unable to translate text"
                self!.loadingVc!.setParams(image: self?.readyImage ?? UIImage(), annotations: [annotation])
            }

           // let resultsVc = ResultsViewController(image: self?.readyImage ?? UIImage(), annotations: result.annotations)
            self!.loadingVc!.setParams(image: self?.readyImage ?? UIImage(), annotations: result.annotations)
        }
    }
    
    // Taken from http://www.goldsborough.me/swift/ios/app/ml/2018/12/10/20-49-02-using_the_google_cloud_vision_api_for_ocr_in_swift/
    private func resize(image: UIImage, to targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle.
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height + 1)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
    self.readyImage = image

    self.dismiss(animated: true, completion: { () -> Void in
        self.detectTextBox(image)
    })

}