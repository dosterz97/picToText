//
//  ViewController.swift
//  picToText
//
//  Created by Zach Doster on 11/8/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var testImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red

        let image = UIImage(named: "GENERIC-CUSTOM-SIGN-PORTRAIT-324x324.jpg")!
        self.testImage = resize(image: image, to: view.frame.size) ?? image
        
        let imageView = UIImageView(frame: view.frame)
        imageView.image = self.testImage
        
//        self.navigationController!.pushViewController(CameraViewController(), animated: true)
//        detectTextBox(for: self.testImage)
        // Do any additional setup after loading the view.
    }

    func detectTextBox(for image: UIImage) {
        ImageToTextClient().gettext(from: self.testImage) { result in
            guard let result = result else {
                fatalError("Did not recognize any text in this image")
            }
            for annotation in result.annotations {
                print(annotation)
                print(annotation.text)
            }
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
