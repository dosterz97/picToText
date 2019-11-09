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

        self.navigationController!.pushViewController(CameraViewController(), animated: true)
    }
}
