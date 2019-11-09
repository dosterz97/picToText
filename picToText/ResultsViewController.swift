//
//  ResultsViewController.swift
//  picToText
//
//  Created by Jack Allen on 11/8/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var image:UIImage
    init(image:UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView.init(image: image)
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let heightConstraint = imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
