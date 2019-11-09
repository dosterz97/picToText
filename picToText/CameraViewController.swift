//
//  CameraViewController.swift
//  picToText
//
//  Created by Jack Allen on 11/8/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    var captureButton: UIButton!
    var artView: UIView!
    var captureSession: AVCaptureSession?
    var tapRecognizer: UITapGestureRecognizer!
    var capturePhotoOutput: AVCapturePhotoOutput! // NEW
    var readyImage: UIImage!                        // NEW

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCamera()
      //  setupTapRecognizer()
        setupPhotoOutput() // NEW
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession?.startRunning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession?.stopRunning()
    }
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            // we will use our local image for testing if we are on simulator
            let image = UIImage(named: "CUSTOM.jpg")!
            readyImage = image
            return detectTextBox(for: image)
        }
        
        var input: AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            fatalError("Error configuring capture device: \(error)");
        }
        
        captureSession = AVCaptureSession()
        
        if captureSession != nil {
            captureSession!.addInput(input)

            // Setup the preview view.
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer)
            
            //configure capture button
            captureButton = UIButton.init(type: .system)
            
            captureButton.backgroundColor = .gray
            captureButton.layer.cornerRadius = 37
            captureButton.layer.masksToBounds = true
         
            view.addSubview(captureButton)

            captureButton.translatesAutoresizingMaskIntoConstraints = false
            captureButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0).isActive = true
            captureButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
            captureButton.heightAnchor.constraint(equalTo: captureButton.widthAnchor).isActive = true
            
        }
    }
    
    private func setupPhotoOutput() {
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOutput)
    }
    
    @objc func handleTap(sender: UIButton) {
        capturePhoto()
    }
    
    func detectTextBox(for image: UIImage) {
        ImageToTextClient().gettext(from: image) { [weak self] result in
            guard let result = result else {
                fatalError("Did not recognize any text in this image")
            }

            let resultsVc = ResultsViewController(image: self?.readyImage ?? UIImage(), annotations: result.annotations)

            self?.navigationController?.pushViewController(resultsVc, animated: true)
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


extension CameraViewController : AVCapturePhotoCaptureDelegate {
    private func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        capturePhotoOutput?.capturePhoto(with: photoSettings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput,
                   didFinishProcessingPhoto photo: AVCapturePhoto,
                   error: Error?) {
    guard error == nil else {
        fatalError("Failed to capture photo: \(String(describing: error))")
    }
        
    guard let imageData = photo.fileDataRepresentation() else {
        fatalError("Failed to convert pixel buffer")
    }
    
    guard let image = UIImage(data: imageData) else {
        fatalError("Failed to convert image data to UIImage")
    }
    readyImage = image;
    
    let testImage = self.resize(image: image, to: view.frame.size) ?? image
    
    let imageView = UIImageView(frame: self.view.frame)
    imageView.image = testImage
    detectTextBox(for: testImage)
  }
}
