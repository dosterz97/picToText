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
    var takePhotoButton: UIButton?
    var viewCameraRollButton: UIButton?
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        takePhotoButton = UIButton.init(type: .roundedRect)
        viewCameraRollButton = UIButton.init(type: .roundedRect)
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(takePhotoButton!)
        view.addSubview(viewCameraRollButton!)
        
        //setup photo button
        takePhotoButton?.setTitleColor(.white, for: .normal)
        takePhotoButton?.layer.borderWidth = 2.0
        takePhotoButton?.layer.borderColor = UIColor.white.cgColor
        takePhotoButton?.setTitle("Take Photo", for: .normal)
        takePhotoButton?.translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePhotoButton?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        takePhotoButton?.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        takePhotoButton?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        takePhotoButton?.addTarget(self, action: #selector(photoButtonPressed(sender:)), for: .touchUpInside)
        
        //setup camera roll button
        viewCameraRollButton?.setTitleColor(.white, for: .normal)
        viewCameraRollButton?.layer.borderWidth = 2.0
        viewCameraRollButton?.layer.borderColor = UIColor.white.cgColor
        viewCameraRollButton?.setTitle("Select from Camera Roll", for: .normal)
        viewCameraRollButton?.translatesAutoresizingMaskIntoConstraints = false
        viewCameraRollButton?.topAnchor.constraint(equalTo: takePhotoButton!.bottomAnchor, constant: 15).isActive = true
        viewCameraRollButton?.centerXAnchor.constraint(equalTo: takePhotoButton!.centerXAnchor).isActive = true
        viewCameraRollButton?.widthAnchor.constraint(equalTo: takePhotoButton!.widthAnchor).isActive = true
        viewCameraRollButton?.heightAnchor.constraint(equalTo: takePhotoButton!.heightAnchor).isActive = true
    }
    @objc func photoButtonPressed(sender: UIButton) {
        //TODO: change this to push the loading v\
        navigationController?.pushViewController(CameraViewController(), animated: true)
    }
}
