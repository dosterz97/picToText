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

    var captureSession: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCamera()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.stopRunning()
    }
    private func setupCamera() {
      let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
      var input: AVCaptureDeviceInput
      do {
        input = try AVCaptureDeviceInput(device: captureDevice!)
      } catch {
        fatalError("Error configuring capture device: \(error)");
      }
      captureSession = AVCaptureSession()
      captureSession.addInput(input)

      // Setup the preview view.
      let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      videoPreviewLayer.frame = view.layer.bounds
      view.layer.addSublayer(videoPreviewLayer)
    }
}
