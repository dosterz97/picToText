//
//  ResultsViewController.swift
//  picToText
//
//  Created by Jack Allen on 11/8/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var annotations: [Annotation]
    var fullMessage: String = ""
    var image:UIImage
    init(image:UIImage, annotations: [Annotation]) {
        self.image = image
        self.annotations = annotations
 //       if annotations[0] && annotations[0].text {
            self.fullMessage = annotations[0].text
   //     }
        
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
        
        let textView = UITextView.init()
        view.addSubview(textView)
        textView.isEditable = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       // let textVerConstraint = textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.text = "Results:\n" + fullMessage
        textView.textAlignment = .center
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
