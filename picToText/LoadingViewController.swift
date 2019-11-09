//
//  LoadingViewController.swift
//  picToText
//
//  Created by Jack Allen on 11/9/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingText = UILabel.init()
        loadingText.textColor = .white
        view.backgroundColor = .gray
        view.addSubview(loadingText)
        loadingText.text = "Loading Results..."
        loadingText.translatesAutoresizingMaskIntoConstraints = false
        loadingText.centerXAnchor.constraint(equalTo: view!.centerXAnchor).isActive = true
        loadingText.centerYAnchor.constraint(equalTo: view!.centerYAnchor).isActive = true
        loadingText.widthAnchor.constraint(equalTo: view!.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    //TODO: migrate api logic from camera vc to loading screen vc
    public func setParams(image:UIImage, annotations:[Annotation]) {
        let resultsVc = ResultsViewController.init(image: image, annotations: annotations)
        self.navigationController?.pushViewController(resultsVc, animated: true)
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
