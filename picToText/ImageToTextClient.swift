//
//  ImageToTextClient.swift
//  picToText
//
//  Created by Zach Doster on 11/8/19.
//  Copyright © 2019 Zach Doster. All rights reserved.
//

import Foundation
import Alamofire

class ImageToTextClient {
    let myAPIKey = "AIzaSyCNA9Av6PekrB_bsZ1XdAIuJWpQMVoOirg"
    lazy var url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(myAPIKey)")
    
    func gettext(from image: UIImage, completion: @escaping (OCRResult?) -> Void) {
        guard let base64Image = base64EncodeImage(image) else {
            print("Error while base64 encoding image")
            completion(nil)
            return
        }
        callGoogleVisionAPI(with: base64Image, completion: completion)
    }
    
    private func callGoogleVisionAPI(
        with base64EncodedImage: String,
        completion: @escaping (OCRResult?) -> Void) {
        let parameters: Parameters = [
            "requests": [
                [
                    "image": [
                        "content": base64EncodedImage
                    ],
                    "features": [
                        [
                            "type": "TEXT_DETECTION"
                        ]
                    ]
                ]
            ]
        ]
        let headers: HTTPHeaders = [
            "X-Ios-Bundle-Identifier": Bundle.main.bundleIdentifier ?? "",
        ]
        Alamofire.request(
            url!,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers)
            .responseData { response in
                if response.result.isFailure {
                    completion(nil)
                    return
                }
                guard let data = response.result.value else {
                    completion(nil)
                    return
                }
                
                let response = try? JSONDecoder().decode(GoogleCloudOCRResponse.self, from: data)
                completion(response?.responses[0])
        }
    }
    
    private func base64EncodeImage(_ image: UIImage) -> String? {
        return image.pngData()?.base64EncodedString(options: .endLineWithCarriageReturn)
    }
}
