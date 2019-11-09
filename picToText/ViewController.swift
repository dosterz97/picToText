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
        
        self.navigationController!.pushViewController(CameraViewController(), animated: true)
    //   detectTextBox(for: self.testImage)
        // Do any additional setup after loading the view.
    }
}
